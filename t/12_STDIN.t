use Test::More 0.98 tests => 4;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use feature qw(say);
use lib 'lib';

use usw;

my $code = qx"cat t/12_STDIN/03_empty.txt | $^X t/12_STDIN/00_detect_auto.pl";
ok !$!, "Successfully detected empty file";

$code = qx"cat t/12_STDIN/04_empty_lines.txt | $^X t/12_STDIN/00_detect_auto.pl";
ok !$!, "Successfully detected file with empty lines";

$code = qx"cat t/12_STDIN/01_utf8.txt | $^X t/12_STDIN/00_detect_auto.pl";
BAIL_OUT $! if $!;
is $?, 0, "succeeded to parse STDIN in utf8";

my $enc = $usw::Encoding;
open my $in,  '<:utf8',           't/12_STDIN/01_utf8.txt'      or fail "open failed: $!";
open my $out, ">:encoding($enc)", 't/12_STDIN/05_generated.txt' or fail "open failed: $!";
my $count = 0;
while (<$in>) {    # copying encoded lines from which was utf8;
    chomp;
    say $out $_;
    $count++;
}
fail "lines are too less" if $count < 30;

$code = qx"cat t/12_STDIN/05_generated.txt | $^X t/12_STDIN/00_detect_auto.pl";
BAIL_OUT $!, if $!;
unlink 't/12_STDIN/05_generated.txt';
is $?, 0, "succeeded to parse STDIN in $enc";

done_testing;
