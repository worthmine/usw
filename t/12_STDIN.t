use Test::More 0.98 tests => 4;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

use usw;

SKIP: {
    skip 'This is a test for environment which is not Windows', 1 if $^O eq 'MSWin32';
    my $code = qx"cat t/12_STDIN/01_utf8.txt | $^X t/12_STDIN/00_detect_auto.pl";
    BAIL_OUT $! if $!;
    is $?, 0, "succeeded to parse STDIN in utf8";
}

SKIP: {
    skip 'this is a test for just only Windows', 1 if $^O ne 'MSWin32';
    my $code = qx"cat t/12_STDIN/02_cp932.txt | $^X t/12_STDIN/00_detect_auto.pl";
    BAIL_OUT $!, if $!;
    is $?, 0, "succeeded to parse STDIN in cp932";
}

my $code = qx"cat t/12_STDIN/03_empty.txt | $^X t/12_STDIN/00_detect_auto.pl";
ok !$!, "Successfully detected empty file";
$code = qx"cat t/12_STDIN/04_empty_lines.txt | $^X t/12_STDIN/00_detect_auto.pl";
ok !$!, "Successfully detected file with empty lines";

done_testing;
