use v6;

use CSS::Grammar::AST :CSSValue;

class CSS::Specification::Terms::Actions {

    has @._proforma;

    method decl($/, :@proforma = @._proforma ) {

        my %ast;

        %ast<ident> = .trim.lc
            with $0;

        with $<val> {
            my Hash $val = .ast;

            with $val<usage> -> $synopsis {
                $.warning( ('usage ' ~ $synopsis, @proforma).flat.join: ' | ');
                return Any;
            }
            elsif ! $val<expr> {
                $.warning('dropping declaration', %ast<ident>);
                return Any;
            }

            %ast<expr> = $val<expr>;
        }

        return %ast;
    }

    method val($/) {
        my %ast;

        with $<usage> {
            %ast<usage> = .ast;
        }
        else {
            with $<proforma> {
                %ast<expr> = [.ast]
            }
            else {
                with $<rx><expr> {
                    %ast<expr> = $.list($_)
                        unless .can('caps') && (!.caps || .caps.first({! .value.ast.defined}));
                }
            }
        }

        make %ast;
    }

    method rule($/) {
        $.node($/).pairs[0];
    }

    method usage($/) {
        make ~ $*USAGE;
    }

    # ---- CSS::Grammar overrides ---- #

    method any-function($/)             {
	##        nextsame if $.lax;
	if $.lax {
	    return $<any-args>
	        ?? $.warning('skipping function arguments', ~$<any-args>)
		!! make $.node($/);
	}
        $.warning('ignoring function', $<Ident>.ast.lc);
    }

    method declaration($/)  {

        if $<any-declaration> {
            my $ast = $<any-declaration>.ast;
            if $ast.defined {
                my ($key, $value) = $ast.kv;
                if $.lax {
                    make {($key ~ ':unknown') => $value}
                }
                else {
                    $.warning('dropping unknown property',
                              $value<at-keyw> ?? '@'~$value<at-keyw> !! $value<ident>);
                }
            }
            return;
        }
        
        my %ast = %( $.decl( $<decl> ) );
        return Any
            unless +%ast;

        if $<any-arg> {
            return $.warning("extra terms following '{%ast<ident>}' declaration",
                             ~$<any-arg>, 'dropped');
        }

        if (my $prio = $<prio> && $<prio>.ast) {
            %ast<prio> = $prio;
        }
        

        make $.token( %ast, :type(CSSValue::Property) );
    }

    method proforma:sym<inherit>($/) { make (:keyw<inherit>) }
    method proforma:sym<initial>($/) { make (:keyw<initial>) }

    #---- Language Extensions ----#

    method length:sym<zero>($/) {
        make $.token(0, :type<px>)
    }

    method angle:sym<zero>($/) {
        make $.token(0, :type<deg>)
    }

    method time:sym<zero>($/) {
        make $.token(0, :type<s>)
    }

    method frequency:sym<zero>($/) {
        make $.token(0, :type<hz>)
    }

    method colors { state Hash $colors //= %CSS::Grammar::AST::CSS21-Colors };

    method color:sym<named>($/) {
        my Str $color-name = $<keyw>.ast.value;
        my @rgb = @( $.colors{$color-name} )
            or die "unknown color: " ~ $color-name;

        my @color = @rgb.map: { (CSSValue::NumberComponent) => $_ };

        make $.token(@color, :type<rgb>);
    }

    method integer($/)     {
        my Int $val = $<uint>.ast;
        $val = -$val
            if $<sign> && $<sign> eq '-';
        make $.token($val, :type(CSSValue::IntegerComponent))
    }

    method number($/)      { make $.token($<num>.ast, :type(CSSValue::NumberComponent)) }
    method uri($/)         { make $<url>.ast }
    method keyw($/)        { make $.token($<id>.lc, :type(CSSValue::KeywordComponent)) }
    # case sensitive identifiers
    method identifier($/)  { make $.token($<name>.ast, :type(CSSValue::IdentifierComponent)) }
    # identifiers strung-together, e.g New Century Schoolbook
    method identifiers($/) { make $.token( $<identifier>.map({ .ast.value }).join(' '), :type(CSSValue::IdentifierComponent)) }
}
