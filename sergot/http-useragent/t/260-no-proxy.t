#!/usr/bin/env perl6

use v6.c;

use Test;

use HTTP::UserAgent;
use HTTP::Request::Common;

%*ENV<NO_PROXY> = 'localhost, foo.bar.com , baz.quux.com';
%*ENV<HTTP_PROXY> = "http://cannibal.local/";

my $ua;

lives-ok { $ua = HTTP::UserAgent.new }, "create with environment NO_PROXY";

is-deeply $ua.no-proxy, [<localhost foo.bar.com baz.quux.com>], "got all from the environment";
nok $ua.use-proxy('localhost'), "use-proxy - in no-proxy";
nok $ua.use-proxy('foo.bar.com'), "use-proxy - in no-proxy";
nok $ua.use-proxy('baz.quux.com'), "use-proxy - in no-proxy";
ok $ua.use-proxy('example.com'), "use-proxy - not there";
ok $ua.use-proxy(GET('http://example.com/')), "use-proxy - with request";
nok $ua.use-proxy(GET('http://localhost:3333/')), "use-proxy - with request (no-proxy)";
nok $ua.get-proxy(GET('http://localhost:3333/')), "get-proxy - (no-proxy)";
is  $ua.get-proxy(GET('http://example.com/')), 'http://cannibal.local/', "get-proxy - with proxy";


done-testing;
# vim: expandtab shiftwidth=4 ft=perl6
