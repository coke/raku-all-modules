use v6;
use MongoDB::Protocol;
use MongoDB::Cursor;

class X::MongoDB::Collection is Exception {
  has $.error-text;                     # Error text
  has $.error-code;                     # Error code if from server
  has $.oper-name;                      # Operation name
  has $.oper-data;                      # Operation data
  has $.full-collection-name;           # Collection name

  method message() {
      return [~] "\n$!oper-name\() error:\n",
                 "  $!error-text",
                 $.error-code.defined ?? "\($!error-code)" !! '',
                 $!oper-data.defined ?? "\n  Data $!oper-data" !! '',
                 "\n  Collection '$!full-collection-name'\n"
                 ;
  }
}

class MongoDB::Collection does MongoDB::Protocol {

  has $.database;
  has Str $.name;

  #-----------------------------------------------------------------------------
  #
  submethod BUILD ( :$database, Str :$name ) {

      $!database = $database;

      if $name ~~ m/^ <[\$ _ A..Z a..z]> <[.\w _]>+ $/ {
          $!name = $name;
      }

      else {
          die X::MongoDB::Collection.new(
              error-text => "Illegal collection name: '$name'",
              oper-name => 'MongoDB::Collection.new()',
              full-collection-name => [~] $!database.name, '.-Ill-'
          );
      }
  }

  #-----------------------------------------------------------------------------
  #
  method insert ( **@documents, Bool :$continue_on_error = False --> Nil ) {

      my $flags = +$continue_on_error;

      # TODO validate keys in documents
      my @docs;
      if @documents.isa(LoL) {
        if @documents[0].isa(Array) and [&&] @documents[0].list>>.isa(Hash) {
          @docs = @documents[0].list;
        }

        elsif @documents.list>>.isa(Hash) {
          @docs = @documents.list;
        }

        else {
          die "Error: Document type not handled by insert";
        }
      }

      else {
        die "Error: Document type not handled by insert";
      }

      self.wire.OP_INSERT( self, $flags, @docs);

      return;
  }

  #-----------------------------------------------------------------------------
  #
  method find (
      %criteria = { }, %projection = { },
      Int :$number_to_skip = 0, Int :$number_to_return = 0,
      Bool :$no_cursor_timeout = False
      --> MongoDB::Cursor
  ) {
      my $flags = +$no_cursor_timeout +< 4;
      my $OP_REPLY;
        $OP_REPLY = self.wire.OP_QUERY( self, $flags, $number_to_skip,
                                        $number_to_return, %criteria,
                                        %projection
                                      );

      return MongoDB::Cursor.new(
          collection  => self,
          OP_REPLY    => $OP_REPLY,
          :%criteria
      );
  }

  #-----------------------------------------------------------------------------
  #
  method find_one ( %criteria = { }, %projection = { } --> Hash ) {

      my MongoDB::Cursor $cursor = self.find( %criteria, %projection,
                                              :number_to_return(1)
                                            );
      my $doc = $cursor.fetch();
      return $doc.defined ?? $doc !! %();
  }

  #-----------------------------------------------------------------------------
  # Get explanation about given search criteria
  #
  method explain ( %criteria = { } --> Hash ) {

      my MongoDB::Cursor $cursor = self.find( %( '$query' => %criteria,
                                                 '$explain' => True
                                               ),
                                               :number_to_return(1)
                                            );
      my $docs = $cursor.fetch();
      return $docs;
  }

  #-----------------------------------------------------------------------------
  # Get count of documents depending on criteria
  #
  method count( %criteria = {} --> Int ) {

      my %req = %( count => $!name,
                   query => %criteria,
                   fields => %()                # Seen with wireshark
                 );
      my $doc = $!database.run_command(%req);

      # Check error and throw X::MongoDB::Collection if there is one
      #
      if $doc<ok>.Bool == False {
          die X::MongoDB::Collection.new(
              error-text => $doc<errmsg>,
              oper-name => 'drop_index',
              oper-data => %req.perl,
              full-collection-name => [~] $!database.name, '.', $!name
          );
      }

      return Int($doc<n>);
  }

  #-----------------------------------------------------------------------------
  # Find distinct values of a field depending on criteria
  #
  method distinct( $field-name!, %criteria = {} --> Array ) {

      my %req = %( distinct => $!name,
                   query => %criteria,
                   key => $field-name                # Seen with wireshark
                 );
      my $doc = $!database.run_command(%req);

      # Check error and throw X::MongoDB::Collection if there is one
      #
      if $doc<ok>.Bool == False {
          die X::MongoDB::Collection.new(
              error-text => $doc<errmsg>,
              oper-name => 'drop_index',
              oper-data => %req.perl,
              full-collection-name => [~] $!database.name, '.', $!name
          );
      }

      # What do we do with $doc<stats> ?
      #
      return $doc<values>.list;
  }

  #-----------------------------------------------------------------------------
  #
  method update (
      %selector, %update,
      Bool :$upsert = False, Bool :$multi_update = False
      --> Nil
  ) {

      my $flags = +$upsert
          + +$multi_update +< 1;

      self.wire.OP_UPDATE( self, $flags, %selector, %update );

      return;
  }

  #-----------------------------------------------------------------------------
  #
  method remove (
      %selector = { },
      Bool :$single_remove = False
      --> Nil
  ) {

      my $flags = +$single_remove;

      self.wire.OP_DELETE( self, $flags, %selector );

      return;
  }

  #-----------------------------------------------------------------------------
  # Add indexes for collection
  #
  # Steps done by the mongo shell
  #
  # * Insert a document into a system table <dbname>.system.indexes
  # * Run get_last_error to see result
  #
  # * According to documentation indexes cannot be changed. They must be
  #   deleted first. Therefore check first. drop index if exists then set new
  #   index.
  #
  method ensure_index ( %key-spec, %options = {} --> Nil ) {

      # Generate name of index if not given in options
      #
      if %options<name>:!exists {
          my Str $name = '';

          # If no name for the index is set then imitate the default of
          # MongoDB or keyname1_dir1_keyname2_dir2_..._keynameN_dirN.
          #
          for %key-spec.keys -> $k {
              $name ~= [~] ($name ?? '_' !! ''), $k, '_', %key-spec{$k};
          }

          %options<name> = $name;
      }


      # Check if index exists
      #
      my $system-indexes = $!database.collection('system.indexes');
      my $doc = $system-indexes.find_one(%(key => %key-spec));

      # If found do nothing for the moment
      #
      if +$doc {
      }

      # Insert index if not exists
      #
      else {

          my %doc = %( ns => ([~] $!database.name, '.', $!name),
                       key => %key-spec,
                       %options
                     );

          $system-indexes.insert(%doc);

          # Check error and throw X::MongoDB::Collection if there is one
          #
          my $error-doc = $!database.get_last_error;
          if $error-doc<err> {
              die X::MongoDB::Collection.new(
                  error-text => $error-doc<err>,
                  error-code => $error-doc<code>,
                  oper-name => 'ensure_index',
                  oper-data => %doc.perl,
                  full-collection-name => [~] $!database.name, '.', $!name
              );
          }
      }

      return;
  }

  #-----------------------------------------------------------------------------
  # Drop an index
  #
  method drop_index ( $key-spec --> Hash ) {

      my %req = %( deleteIndexes => $!name,
                   index => $key-spec,
                 );

      my $doc = $!database.run_command(%req);

      # Check error and throw X::MongoDB::Collection if there is one
      #
      if $doc<ok>.Bool == False {
          die X::MongoDB::Collection.new(
              error-text => $doc<errmsg>,
              oper-name => 'drop_index',
              oper-data => %req.perl,
              full-collection-name => [~] $!database.name, '.', $!name
          );
      }

      return $doc;
  }

  #-----------------------------------------------------------------------------
  # Drop all indexes
  #
  method drop_indexes ( --> Hash ) {
      return self.drop_index('*');
  }

  #-----------------------------------------------------------------------------
  # Drop collection
  #
  method drop ( --> Hash ) {

      my %req = %(drop => $!name);
      my $doc = $!database.run_command(%req);
      if $doc<ok>.Bool == False {
          die X::MongoDB::Collection.new(
              error-text => $doc<errmsg>,
              oper-name => 'drop',
              oper-data => %req.perl,
              full-collection-name => [~] $!database.name, '.', $!name
          );
      }

      return $doc;
  }

  #-----------------------------------------------------------------------------
  # Get indexes for the current collection
  #
  method get_indexes ( --> MongoDB::Cursor ) {
      
      my $system-indexes = $!database.collection('system.indexes');
      return $system-indexes.find(%(ns => [~] $!database.name, '.', $!name));
  }
}
