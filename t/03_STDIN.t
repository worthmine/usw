use Test::More 0.98 tests => 2;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

use usw;

my $code = qx"cat t/share/00_utf8.txt | $^X t/share/02_utf8.pl";
BAIL_OUT $! if $!;
is $?, 0, "succeeded to parse STDIN in utf8";

SKIP: {
    skip 'It is tests for just only Windows', 1 if $^O ne 'MSWin32';
    my $code = qx"cat t/share/01_cp932.txt | $^X t/share/03_cp932.pl";
    BAIL_OUT $!, if $!;
    is $?, 0, "succeeded to parse STDIN in cp932";
}

done_testing;
