#!perl6

use Test;

# do NOT move this below `Pod::To::HTML` line, the module exports a fake Pod::Defn
constant no-pod-defn = ::('Pod::Defn') ~~ Failure;

use Pod::To::HTML;

plan :skip-all<Compiler does not support Pod::Defn> if no-pod-defn;
plan 1;

=begin pod

=defn  MAD
Affected with a high degree of intellectual independence.

=defn  MEEKNESS
Uncommon patience in planning a revenge that is worth while.

=defn MORAL
Conforming to a local and mutable standard of right.
Having the quality of general expediency.

=end pod

say $=pod[0].perl;

my $html = pod2html($=pod[0]);

#say $html;
ok $html ~~ ms[[
'<dl>'
'<dt>MAD</dt>'
'<dd><p>Affected with a high degree of intellectual independence.</p>'
'</dd>'
'<dt>MEEKNESS</dt>'
'<dd><p>Uncommon patience in planning a revenge that is worth while.</p>'
'</dd>'
'<dt>MORAL</dt>'
'<dd><p>Conforming to a local and mutable standard of right. Having the quality of general expediency.</p>'
'</dd>'

'</dl>'
]], 'generated html for =defn';
