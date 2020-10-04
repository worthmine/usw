use Test::More 0.98;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

use usw;

SKIP: {
    skip 'It is tests for just only Windows', 1 if $^O ne 'MSWin32';
    my $code = qx"cat t/share/01_cp932.txt | $^X t/share/03_cp932.pl >/dev/null 2>&1";
    ok defined $code, "succeeded to parse STDIN in utf8";
}

done_testing;
