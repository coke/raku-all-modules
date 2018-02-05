use v6;
unit class Term::TablePrint:ver<1.0.10>;

use NCurses;
use Term::Choose::NCursesAdd;

use Term::Choose           :choose, :choose-multi, :pause;
use Term::Choose::LineFold :to-printwidth, :line-fold, :print-columns;
use Term::Choose::Util     :insert-sep, :unicode-sprintf;


has %!o;

has WINDOW $.win;
has Bool $!reset_win;

subset Int_0_to_2 of Int where * == 0|1|2;
subset Int_0_or_1 of Int where * == 0|1;

has UInt       $.max-rows       = 50_000;
has UInt       $.min-col-width  = 30;
has UInt       $.progress-bar   = 5_000;
has UInt       $.tab-width      = 2;
has Int_0_or_1 $.add-header; # DEPRECATED
has Int_0_or_1 $.grid           = 0;
has Int_0_or_1 $.keep-header    = 1;
has Int_0_or_1 $.mouse          = 0;
has Int_0_to_2 $.choose-columns = 0; # Int_0_or_1
has Int_0_to_2 $.table-expand   = 1;
has Str        $.prompt         = '';
has Str        $.undef          = '';

has List $!table;
has Int  @!w_cols;
has Int  @!w_heads;
has Int  @!new_w_cols;
has Int  @!not_a_number;

has Int $!tab_w; #
has Str $!info_row;
has Int $!total;
has Int $!bar_w;
has Str $!thsd_sep = ',';
has Int $!show_progress = 0;
has Str $!progressbar_fmt = 'Computing: [%s%s]';

has Term::Choose $!tc;


method !_init_term {
    if ! $!win {
        $!reset_win = True;
        my int32 constant LC_ALL = 6;
        setlocale( LC_ALL, "" );
        $!win = initscr();
    }
    $!tc =Term::Choose.new( :win( $!win ), :mouse( %!o<mouse> ) );
}

method !_end_term {
    return if ! $!reset_win;
    endwin();
}


sub print-table ( @orig_table, *%opt ) is export( :DEFAULT, :print-table ) {
    return Term::TablePrint.new().print-table( @orig_table, |%opt );
}

method print-table (
        @orig_table,
        UInt       :$max-rows       = $!max-rows,
        UInt       :$min-col-width  = $!min-col-width,
        UInt       :$progress-bar   = $!progress-bar,
        UInt       :$tab-width      = $!tab-width,
        Int_0_or_1 :$add-header     = $!add-header, # DEPRECATED
        Int_0_or_1 :$grid           = $!grid,
        Int_0_or_1 :$keep-header    = $!keep-header,
        Int_0_or_1 :$mouse          = $!mouse,
        Int_0_to_2 :$choose-columns = $!choose-columns, # Int_0_or_1
        Int_0_to_2 :$table-expand   = $!table-expand,
        Str        :$prompt         = $!prompt,
        Str        :$undef          = $!undef,
    ) {
    %!o = :$max-rows, :$min-col-width, :$progress-bar, :$tab-width, :$add-header, :$grid,
          :$keep-header, :$mouse, :$choose-columns, :$table-expand, :$prompt, :$undef;
    CATCH {
        endwin();
    } 
    self!_init_term();

    # ### remove and choose-columns datatype to Int_0_or_1
    if $choose-columns == 2 {
        $!tc.pause( ( 'Close with ENTER', ), :prompt( 'Option "choose-columns": 2 is no longer a valid value!' ) );
    }
    # ###

    if ! @orig_table.elems {
        $!tc.pause( ( 'Close with ENTER', ), :prompt( '"print-table": Empty table!' ) );
        self!_end_term;
        return;
    }

    # ### remove and pod
    if %!o<add-header>.defined {
        $!tc.pause( ( 'Close with ENTER', ), :prompt( 'The \'print-table\' option "add-header" is deprecated and will be removed.' ) );
        if %!o<add-header> {
            @orig_table.unshift: [ ( 1 .. @orig_table[0].elems ).map: { $_ ~ 'col' } ];
        }
    }
    # ###

    $!tab_w = %!o<tab-width>;
    if %!o<grid> && %!o<tab-width> %% 2 {
        $!tab_w++;
    }
    my Int @chosen;
    if %!o<choose-columns> {
        @chosen = self!_choose_columns( @orig_table[0] ) if %!o<choose-columns>;
        if @chosen.elems && ! @chosen[0].defined {
            self!_end_term();
            return;
        }
    }
    my Int $table_row_count = @orig_table.elems - 1;
    if @chosen.elems {
        # max-rows is index because first row in @orig_table is header row
        my $idx_last = %!o<max-rows> && $table_row_count >= %!o<max-rows> ?? %!o<max-rows> !! @orig_table.end;
        $!table = [ ( 0 .. $idx_last ).map: { [ @orig_table[$_][@chosen] ] } ];
    }
    elsif %!o<max-rows> && $table_row_count >= %!o<max-rows> {
        $!info_row = sprintf( 'Reached the row LIMIT %d', insert-sep( %!o<max-rows>, $!thsd_sep ) );
        if $table_row_count > %!o<max-rows> {
            $!info_row ~= sprintf( '  (total %d)', insert-sep( $table_row_count, $!thsd_sep ) );
        }
        $!table = @orig_table[0 .. %!o<max-rows>];
        #$!total = %!o<max-rows> + 1;
    }
    else {
        $!table = @orig_table;
    }
    $!total = $!table.elems;
    if %!o<progress-bar> {
        $!show_progress = $!total * $!table[0].elems div %!o<progress-bar>;
        if $!show_progress {
            curs_set( 0 );
        }
    }
    self!_calc_col_width();
    self!_win_size_dependet_code();
    self!_end_term();
    return;
}


method !_win_size_dependet_code {
    my Int $term_w = getmaxx( $!win );
    my Int $table_w = self!_calc_avail_col_width( $term_w );
    return if ! $table_w;
    my @list;
    self!_col_to_avail_col_width( @list );
    my Str @header;
    if %!o<prompt> {
        @header.push: %!o<prompt>;
    }
    if %!o<keep-header> {
        @header.push: @list.shift;
        @header.push: self!_header_separator if %!o<grid>;
    }
    else {
        @list.splice( 1, 0, self!_header_separator ) if %!o<grid>;
    }

    if $!info_row {
        if print-columns( $!info_row ) > $table_w {
            @list.push: to-printwidth( $!info_row, $table_w - 3 ) ~ '...';
        }
        else {
            @list.push: $!info_row;
        }
    }
    my Int $old_row = 0;
    my Int $auto_jumped_to_row_0 = 2;
    my Int $row_is_expanded = 0;

    loop {
        if getmaxx( $!win ) != $term_w {
            $term_w = getmaxx( $!win );
            self!_win_size_dependet_code();
            return;
        }
        if ( %!o<keep-header> && ! @list.elems ) || ( ! %!o<keep-header> && @list.elems == 1 ) {
            # Choose
            $!tc.pause( ( Any, |$!table[0] ), :prompt( 'EMPTY!' ), :0layout, :undef( '<<' ) );
            return;
        }
        # Choose
        my Int $row = $!tc.choose( @list, :prompt( @header.join: "\n" ), :ll( $table_w ),
                                          :default( $old_row ), :1index, :2layout );
        return if ! $row.defined;
        next   if $row == -1; # ll + changed window size: choose returns -1
        if ! %!o<table-expand> {
            return if $row == 0;
            next;
        }
        if $old_row == $row {
            if $row == 0 {
                if ! %!o<keep-header> {
                    return;
                }
                elsif %!o<table-expand> == 1 {
                    return if $row_is_expanded;
                    return if $auto_jumped_to_row_0 == 1;
                }
                elsif %!o<table-expand> == 2 {
                    return if $row_is_expanded;
                }
                $auto_jumped_to_row_0 = 0;
            }
            else {
                $old_row = 0;
                $auto_jumped_to_row_0 = 1;
                $row_is_expanded = 0;
                next;
            }
        }
        $old_row = $row;
        $row_is_expanded = 1;
        if $!info_row && $row == @list.end {
            $!tc.pause( ( 'Close', ), :prompt( $!info_row ), :mouse( %!o<mouse> ) );
            next;
        }
        if %!o<keep-header> {
            $row++;
        }
        else {
            if %!o<grid> {
                next   if $row == 1;
                $row-- if $row > 1;
            }
        }
        self!_print_single_table_row( $row );
    }
}


method !_print_single_table_row ( Int $row ) {
    my Int $term_w = getmaxx( $!win );
    my Int $key_w = @!w_heads.max + 1; #
    if $key_w > $term_w div 100 * 33 {
        $key_w = $term_w div 100 * 33;
    }
    my Str $separator = ' : ';
    my Int $sep_w = $separator.chars;
    my $col_w = $term_w - ( $key_w + $sep_w + 1 ); #
    my @lines = ' Close with ENTER';
    for 0 .. $!table[$row].end -> $col {
        my Str $key = to-printwidth(
            _sanitized_string( $!table[0][$col] // %!o<undef> ),
            $key_w,
            False
        ).[0];
        my Str $sep = $separator;
        @lines.push: ' ';
        if  $!table[$row][$col].defined && ! $!table[$row][$col].chars { ##
            @lines.push: sprintf "%*.*s%*s%s", $key_w xx 2, $key, $sep_w, $sep, '';
        }
        else {
            for line-fold( $!table[$row][$col], $col_w, '', '' ) -> $line {
                @lines.push: sprintf "%*.*s%*s%s", $key_w xx 2, $key, $sep_w, $sep, $line;
                $key = '' if $key;
                $sep = '' if $sep;
            }
        }
    }
    $!tc.pause( @lines, :prompt( '' ), :2layout );
}


method !_calc_col_width {
    my Int @col_idx = 0 .. $!table[0].end; #
    for @col_idx -> $col {
       $!table[0][$col] = _sanitized_string( ( $!table[0][$col] // %!o<undef> ) );
       @!w_heads[$col] = print-columns( $!table[0][$col] );
    }
    my Bool $undef_n = %!o<undef> !~~ Numeric;
    my Str $undef    = _sanitized_string( %!o<undef> );
    my Int $undef_w  = print-columns( $undef );
    my Int $step;
    if $!show_progress >= 2 {
        $!bar_w = getmaxx( $!win ) - ( sprintf $!progressbar_fmt, '', '' ).chars - 1;
        $step = $!total div $!bar_w || 1;
    }
    my Int $threads = Term::Choose.new.num-threads();
    while $threads * 2 > $!total {
        last if $threads == 1;
        $threads = $threads div 2;
    }
    my $size = $!total div $threads;
    my @portions = ( ^$threads ).map: { [ $size * $_, $size * ( $_ + 1 ) ] };
    @portions[0][0] = 1; # 0 already done
    @portions[@portions.end][1] = $!total;
    my @promise;
    my $lock = Lock.new();
    my Int $count = 0;
    for @portions -> $range {
        my @cache;
        @promise.push: start {
            do for $range[0] ..^ $range[1] -> $row {
                if $step {
                    $lock.protect( { ++$count; self!_progressbar_update( $count ) if $count %% $step } );
                }
                do for @col_idx -> $col {
                    if ! $!table[$row][$col].defined {
                        $row, $col, $undef, $undef_w, $undef_n;
                    }
                    else {
                        my $nan := $!table[$row][$col] !~~ Numeric;
                        my $str := _sanitized_string( $!table[$row][$col] );
                        $row, $col, $str, print-columns( $str, @cache ), $nan;
                    }
                }
            }
        };
    }
    @!w_cols = 1 xx $!table[0].elems;
    for await @promise -> @portion {
        for @portion -> @p_rows {
            for @p_rows {
                $!table[.[0]][.[1]] := .[2];
                if .[3] > @!w_cols[.[1]] {
                    @!w_cols[.[1]] := .[3];
                }
                if .[4] {
                    ++@!not_a_number[.[1]];
                }
            }
        }
    }
    self!_progressbar_update( $!total ) if $step && $!total % $step;
}


method !_calc_avail_col_width ( Int $term_w ) {
    @!new_w_cols  = @!w_cols;
    my Int $avail_w = $term_w - $!tab_w * @!new_w_cols.end;
    my Int $sum = [+] @!new_w_cols;
    if $sum < $avail_w {
        HEAD: loop {
            my Int $count = 0;
            for ^@!w_heads -> $i {
                if @!w_heads[$i] > @!new_w_cols[$i] {
                    ++@!new_w_cols[$i];
                    ++$count;
                    last HEAD if ( $sum + $count ) == $avail_w;
                }
            }
            last HEAD if $count == 0;
            $sum += $count;
        }
    }
    elsif $sum > $avail_w {
        my Int $mininum_w = %!o<min-col-width> || 1;
        if @!w_heads.elems > $avail_w {
            self!_print_term_not_wide_enough_message();
            return;
        }
        my Int @tmp_cols_w = @!new_w_cols;
        my Int $percent = 0;

        MIN: while $sum > $avail_w {
            ++$percent;
            my Int $count = 0;
            for ^@tmp_cols_w -> $i {
                if $mininum_w >= @tmp_cols_w[$i] {
                    next;
                }
                if $mininum_w >= _minus_x_percent( @tmp_cols_w[$i], $percent ) {
                    @tmp_cols_w[$i] = $mininum_w;%!o<undef>
                }
                else {
                    @tmp_cols_w[$i] = _minus_x_percent( @tmp_cols_w[$i], $percent );
                }
                ++$count;
            }
            $sum = [+] @tmp_cols_w;
            $mininum_w-- if $count == 0;
            #last MIN if $mininum_w == 0;
        }
        my Int $rest = $avail_w - $sum;
        if $rest {

            REST: loop {
                my $count = 0;
                for ^@tmp_cols_w -> $i {
                    if @tmp_cols_w[$i] < @!new_w_cols[$i] {
                        @tmp_cols_w[$i]++;
                        $rest--;
                        $count++;
                        last REST if $rest == 0;
                    }
                }
                last REST if $count == 0;
            }
        }
        @!new_w_cols = [ @tmp_cols_w ] if @tmp_cols_w.elems;
    }
    return [+] |@!new_w_cols, $!tab_w * @!new_w_cols.end;
}


method !_col_to_avail_col_width( @list ) {
    my Int $step;
    if $!show_progress {
        $!bar_w = getmaxx( $!win ) - ( sprintf $!progressbar_fmt, '', '' ).chars - 1;
        $step = $!total div $!bar_w || 1;    #
    }
    my Int @col_idx = 0 .. @!new_w_cols.end;
    my Str $tab;
    if %!o<grid> {
        $tab = ( ' ' x $!tab_w div 2 ) ~ '|' ~ ( ' ' x $!tab_w div 2 );
    }
    else {
        $tab = ' ' x $!tab_w;
    }
    my $threads = Term::Choose.new.num-threads();
    while $threads > $!total {
        last if $threads == 1;
        $threads = $threads div 2;
    }
    my $size = $!total div $threads;
    my @portions = ( ^$threads ).map: { [ $size * $_, $size * ( $_ + 1 ) ] };
    @portions[@portions.end][1] = $!total;
    my @promise;
    my $lock = Lock.new();
    my Int $count = 0;
    for @portions -> $range {
        my @cache;
        @promise.push: start {
            do for $range[0] ..^ $range[1] -> $row {
                my Str $str = '';
                for @col_idx -> $col {
                    $str ~= unicode-sprintf( $!table[$row][$col], @!new_w_cols[$col], ! @!not_a_number[$col], @cache );
                    $str ~= $tab if $col != @!new_w_cols.end;
                }
                if $step {
                    $lock.protect( { ++$count; self!_progressbar_update( $count ) if $count %% $step } );
                }
                $row, $str;
            }
        };
    }
    for await @promise -> @portion {
        for @portion {
            @list[.[0]] = .[1];
        }
    }
    self!_progressbar_update( $!total ) if $step && $!total % $step;
}


method !_choose_columns ( @avail_cols ) {
    my Str $init_prompt = 'Columns: ';
    my Str $ok = '-ok-';
    my Str @pre = ( Str, $ok );
    my Int @col_idxs;
    my @cols = @avail_cols.map( { $_ // %!o<undef> } );

    loop {
        my Str @chosen_cols = @col_idxs.list ?? @cols[@col_idxs] !! '*';
        my Str $prompt = $init_prompt ~ @chosen_cols.join: ', ';
        my Str @choices = |@pre, |@cols;
        # Choose
        my Int @idx = $!tc.choose-multi( @choices, :prompt( $prompt ), :1index, :lf( 0, $init_prompt.chars ),
                                                   :no-spacebar( |^@pre ), :undef( '<<' ) );
        if ! @idx[0].defined || @idx[0] == 0 {
            if @col_idxs.elems {
                @col_idxs = [];
                next;
            }
            return;
        }
        elsif @choices[@idx[0]].defined && @choices[@idx[0]] eq $ok {
            @idx.shift;
            @col_idxs.append: @idx >>->> @pre.elems;
            return @col_idxs;
        }
        @col_idxs.append: @idx >>->> @pre.elems;
    }
}

method !_header_separator { 
    my Str $header_sep = '';
    my Str $tab = ( '-' x $!tab_w div 2 ) ~ '|' ~ ( '-' x $!tab_w div 2 );
    for ^@!new_w_cols {
        $header_sep ~= '-' x @!new_w_cols[$_];
        $header_sep ~= $tab if $_ != @!new_w_cols.end;
    }
    return $header_sep;
}

sub _sanitized_string ( $str ) {
    $str.trim.subst( / \s+ /, ' ', :g ).subst( / <:C> /, '', :g );
}

method !_progressbar_update( Int $count ) {
    my $multi = ( $count / ( $!total / $!bar_w ) ).ceiling;
    #my $ext ~= ' ' ~ ( $multi * ( 100 / $!bar_w ) ).Int ~ "%";
    clear();
    mvaddstr( 0, 0, sprintf $!progressbar_fmt, '=' x $multi, ' ' x $!bar_w - $multi );
    nc_refresh();
}

method !_print_term_not_wide_enough_message {
    my $prompt1 = 'Terminal window is not wide enough to print this table.';
    $!tc.pause( [ 'Press ENTER to show the column names.' ], :prompt( $prompt1 ) );
    my Str $prompt2 = 'Reduce the number of columns".' ~ "\n" ~ 'Close with ENTER.';
    $!tc.pause( $!table[0], :prompt( $prompt2 ) );
}

sub _minus_x_percent ( Int $value, Int $percent ) {
    my Int $new = ( $value - ( $value / 100 * $percent ) ).Int;
    return $new > 0 ?? $new !! 1;
}







=begin pod

=head1 NAME

Term::TablePrint - Print a table to the terminal and browse it interactively.

=head1 SYNOPSIS

=begin code

    use Term::TablePrint :print-table;


    my @table = ( [ 'id', 'name' ],
                  [    1, 'Ruth' ],
                  [    2, 'John' ],
                  [    3, 'Mark' ],
                  [    4, 'Nena' ], );


    # Functional style:

    print-table( @table );


    # or OO style:

    my $pt = Term::TablePrint.new();

    $pt.print-table( @table, :mouse(1), :choose-columns(1) );

=end code

=head1 DESCRIPTION

C<print-table> shows a table and lets the user interactively browse it. It provides a cursor which highlights the row
on which it is located. The user can scroll through the table with the different cursor keys - see L<#KEYS>.

If the table has more rows than the terminal, the table is divided up on as many pages as needed automatically. If the
cursor reaches the end of a page, the next page is shown automatically until the last page is reached. Also if the
cursor reaches the topmost line, the previous page is shown automatically if it is not already the first one.

If the terminal is too narrow to print the table, the columns are adjusted to the available width automatically.

If the option table-expand is enabled and a row is selected with C<Return>, each column of that row is output in its own
line preceded by the column name. This might be useful if the columns were cut due to the too low terminal width.

Before the output modifications are made (at a copy of the original data). Leading and trailing whitespaces are removed
and spaces are squashed to a single white-space. In addition, characters of the Unicode property C<Other> are removed.

The elements in a column are right-justified if one or more elements of that column do not look like a number, else they
are left-justified.

=head1 USAGE

=head2 KEYS

Keys to move around:

=item the C<ArrowDown> key (or the C<j> key) to move down and  the C<ArrowUp> key (or the C<k> key) to move up.

=item the C<PageUp> key (or C<Ctrl-B>) to go back one page, the C<PageDown> key (or C<Ctrl-F>) to go forward one page.

=item the C<Home> key (or C<Ctrl-A>) to jump to the first row of the table, the C<End> key (or C<Ctrl-E>) to jump to the last
row of the table.

With I<format> set to C<0> the C<Return> key closes the table if the cursor is on the header row.

If I<format> is enabled (set to C<1> or C<2>) and I<table-expand> is set to C<0>, the C<Return> key closes the table if the cursor is on
the first row.

If I<format> and I<table-expand> are enabled and the cursor is on the first row, pressing C<Return> three times in
succession closes the table. If I<table-expand> is set to C<1> and the cursor is auto-jumped to the first row, it is
required only one C<Return> to close the table.

If the cursor is not on the first row:

=item1 with the option I<table-expand> disabled the cursor jumps to the table head if C<Return> is pressed.

=item1 with the option I<table-expand> enabled each column of the selected row is output in its own line preceded by the
column name if C<Return> is pressed. Another C<Return> closes this output and goes back to the table output. If a row is
selected twice in succession, the pointer jumps to the head of the table or to the first row if I<keep-header> is
enabled.

If the width of the window is changed and the option I<table-expand> is enabled, the user can rewrite the screen by
choosing a row.

If the option I<choose-columns> is enabled, the C<SpaceBar> key (or the right mouse key) can be used to select columns -
see option L</choose-columns>.

=head1 CONSTRUCTOR

The constructor method C<new> can be called with named arguments. For the valid options see L<#OPTIONS>. Setting the
options in C<new> overwrites the default values for the instance.

Additionally to the options mentioned below one can set the option L<win>. The opton L<win> expects as its value a
C<WINDOW> object - the return value of L<NCurses> C<initscr>.

If set, C<print-table> uses this global window instead of creating its own without calling C<endwin> to restores the
terminal before returning.

=head1 ROUTINES

=head2 print-table

C<print-table> prints the table passed with the first argument.

    print-table( @table, *%options );

The first argument is an list of arrays. The first array of these arrays holds the column names. The following arrays
are the table rows where the elements are the field values.

The following arguments set the options (key-values pairs).

=head1 OPTIONS

Defaults may change in future releases.

=head2 prompt

String displayed above the table.

=head2 add-header DEPRECATED

This option is deprecated and will be removed.

Enabling I<add-header> alters the passed list.

If I<add-header> is set to 1, C<print-table> adds a header row - the columns are numbered starting with 1.

Default: 0

=head2 choose-columns

If I<choose-columns> is set to 1, the user can choose which columns to print. Columns can be added (with the
C<SpaceBar> and the C<Return> key) until the user confirms with the I<-ok-> menu entry.

Default: 0

=head2 keep-header

If I<keep-header> is set to 0, the table header is shown on top of the first page.

=begin code

    .----------------------------.    .----------------------------.    .----------------------------.
    |col1   col2     col3   col3 |    |.....  .......  .....  .....|    |.....  .......  .....  .....|
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |.....  .......  .....  .....|
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    | 1/3                        |    | 2/3                        |    | 3/3                        |
    '----------------------------'    '----------------------------'    '----------------------------'

=end code

If I<keep-header> is set to 1, the table header is shown on top of each page.

=begin code

    .----------------------------.    .----------------------------.    .----------------------------.
    |col1   col2     col3   col3 |    |col1   col2     col3   col4 |    |col1   col2     col3   col4 |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |.....  .......  .....  .....|
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |.....  .......  .....  .....|
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |.....  .......  .....  .....|
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    |.....  .......  .....  .....|    |.....  .......  .....  .....|    |                            |
    | 1/3                        |    | 2/3                        |    | 3/3                        |
    '----------------------------'    '----------------------------'    '----------------------------'

=end code

Default: 1

=head2 grid

If I<grid> is set to 1 lines separate the columns from each other and the header from the body.

=begin code

    .----------------------------.
    |col1 | col2   | col3 | col3 |
    |-----|--------|------|------|
    |.... | ...... | .... | .... |
    |.... | ...... | .... | .... |
    |.... | ...... | .... | .... |
    |.... | ...... | .... | .... |
    |.... | ...... | .... | .... |
    |.... | ...... | .... | .... |
    |.... | ...... | .... | .... |
    |.... | ...... | .... | .... |
    '----------------------------'

=end code

If set to 0 the table is shown with no grid.

=begin code

    .----------------------------.
    |col1  col2     col3   col3  |
    |....  .......  .....  ..... |
    |....  .......  .....  ..... |
    |....  .......  .....  ..... |
    |....  .......  .....  ..... |
    |....  .......  .....  ..... |
    |....  .......  .....  ..... |
    |....  .......  .....  ..... |
    |....  .......  .....  ..... |
    |                            |
    '----------------------------'

=end code

Default: 0

=head2 max-rows

Set the maximum number of used table rows. The used table rows are kept in memory.

To disable the automatic limit set I<max-rows> to 0.

If the number of table rows is equal to or higher than I<max-rows>, the last row of the output says
C<REACHED LIMIT "MAX_ROWS": $limit> or C<=LIMIT= $limit> if the previous doesn't fit in the row.

Default: 50_000

=head2 min-col-width

The columns with a width below or equal I<min-col-width> are only trimmed if it is still required to lower the row width
despite all columns wider than I<min-col-width> have been trimmed to I<min-col-width>.

Default: 30

=head2 mouse

Set the I<mouse> mode (see option C<mouse> in L<Term::Choose|https://github.com/kuerbis/Term-Choose-p6>).

Default: 0

=head2 progress-bar

Set the progress bar threshold. If the number of fields (rows x columns) is higher than the threshold, a progress bar is
shown while preparing the data for the output. Setting the value to C<0> disables the progress bar.

Default: 10_000

=head2 tab-width

Set the number of spaces between columns. If I<format> is set to C<2> and I<tab-width> is even, the spaces between the
columns are I<tab-width> + 1 print columns.

Default: 2

=head2 table-expand

If the option I<table-expand> is set to C<1> or C<2> and C<Return> is pressed, the selected table row is printed with
each column in its own line. Exception: if I<table-expand> is set to C<1> and the cursor auto-jumped to the first row,
the first row will not be expanded.

=begin code

    .----------------------------.        .----------------------------.
    |col1 | col2   | col3 | col3 |        |                            |
    |-----|--------|------|------|        |col1 : ..........           |
    |.... | ...... | .... | .... |        |                            |
    |.... | ...... | .... | .... |        |col2 : .....................|
   >|.... | ...... | .... | .... |        |       ..........           |
    |.... | ...... | .... | .... |        |                            |
    |.... | ...... | .... | .... |        |col3 : .......              |
    |.... | ...... | .... | .... |        |                            |
    |.... | ...... | .... | .... |        |col4 : .............        |
    |.... | ...... | .... | .... |        |                            |
    '----------------------------'        '----------------------------'

=end code

If I<table-expand> is set to 0, the cursor jumps to the to first row (if not already there) when C<Return> is pressed.

Default: 1

=head2 undef

Set the string that will be shown on the screen instead of an undefined field.

Default: "" (empty string)

=head1 ENVIRONMET VARIABLES

=head2 multithreading

C<Term::TablePrint> uses multithreading when preparing the list for the output; the number of threads to use can be set
with the environment variable C<TC_NUM_THREADS>. To find out the setting of "number of treads" see
L<Term::Choose>/ENVIRONMET.

head2 libncurses

The location of the used ncurses library can be specified by setting the environment variable C<PERL6_NCURSES_LIB>. This
will overwrite the autodetected ncurses library location.

=head1 REQUIREMENTS

=head2 libncurses

Requires C<libncursesw> to be installed. If the list elements contain wide characters, it is required an approprirate
ncurses library else wide character will break the output.

=head2 Monospaced font

It is required a terminal that uses a monospaced font which supports the printed characters.

=head1 CREDITS

Thanks to the people from L<Perl-Community.de|http://www.perl-community.de>, from
L<stackoverflow|http://stackoverflow.com> and from L<#perl6 on irc.freenode.net|irc://irc.freenode.net/#perl6> for the
help.

=head1 AUTHOR

Matthäus Kiem <cuer2s@gmail.com>

=head1 LICENSE AND COPYRIGHT

Copyright 2016-2018 Matthäus Kiem.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
