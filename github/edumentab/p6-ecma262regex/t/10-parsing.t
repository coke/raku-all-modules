use v6;
use ECMA262Regex;
use Test;

ok ECMA262Regex::Parser.parse('^\d+$');
ok ECMA262Regex::Parser.parse('a|b');
ok ECMA262Regex::Parser.parse('\bass\b');
ok ECMA262Regex::Parser.parse('^(?=a|b)\w+$');
ok ECMA262Regex::Parser.parse('^(?!0)\d+$');
ok ECMA262Regex::Parser.parse('^\d*?9$');
ok ECMA262Regex::Parser.parse('^a{2}b{3,}c{1,4}$');
ok ECMA262Regex::Parser.parse('^.(\w)(?:\d+)$');
ok ECMA262Regex::Parser.parse('(\w)\1');
ok ECMA262Regex::Parser.parse('\t\n');
ok ECMA262Regex::Parser.parse('\\\\');
ok ECMA262Regex::Parser.parse('\x61');
ok ECMA262Regex::Parser.parse('[abc]+');
ok ECMA262Regex::Parser.parse('[^open]+');
ok ECMA262Regex::Parser.parse('[A-Fa-f]+');
ok ECMA262Regex::Parser.parse('[-]{2}');
ok ECMA262Regex::Parser.parse('^[\d.]+$');
ok ECMA262Regex::Parser.parse('\t');
nok ECMA262Regex::Parser.parse('\a');
done-testing;
