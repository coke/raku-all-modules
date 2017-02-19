use v6;

use Test;
use Perl6::Parser;

plan 2;

my $pt = Perl6::Parser.new;
my $*CONSISTENCY-CHECK = True;
my $*GRAMMAR-CHECK = True;

subtest {
	plan 2;

	subtest {
		plan 3;

		subtest {
			my $p = $pt.parse( Q{my Int $a} );
			my $tree = $pt.build-tree( $p );
			is $pt.to-string( $tree ),
				Q{my Int $a}, Q{formatted};

			done-testing;
		}, Q{regular};

		subtest {
			my $p = $pt.parse( Q{my Int:U $a} );
			my $tree = $pt.build-tree( $p );
			is $pt.to-string( $tree ),
				Q{my Int:U $a}, Q{formatted};

			done-testing;
		}, Q{undefined};

		subtest {
			my $p = $pt.parse( Q{my Int:D $a = 0} );
			my $tree = $pt.build-tree( $p );
			is $pt.to-string( $tree ),
				Q{my Int:D $a = 0},
				Q{formatted};

			done-testing;
		}, Q{defined};
	}, Q{typed};

	subtest {
		plan 1;

		subtest {
			my $p = $pt.parse( Q{my $a where 1} );
			my $tree = $pt.build-tree( $p );
			is $pt.to-string( $tree ),
				Q{my $a where 1}, Q{formatted};

			done-testing;
		}, Q{my $a where 1};
	}, Q{constrained};
}, Q{variable};

subtest {
	plan 1;

	subtest {
		plan 2;

		subtest {
			my $source = Q{sub foo returns Int {}};
			my $p = $pt.parse( $source );
			my $tree = $pt.build-tree( $p );
			is $pt.to-string( $tree ), $source, Q{formatted};

			done-testing;
		}, Q{ws};
		subtest {
			my $source = Q:to[_END_];
sub foo returns Int {}
_END_
			my $p = $pt.parse( $source );
			my $tree = $pt.build-tree( $p );
			is $pt.to-string( $tree ), $source, Q{formatted};

			done-testing;
		}, Q{ws};
	}, Q{sub foo returns Int {}};
}, Q{subroutine};

# vim: ft=perl6
