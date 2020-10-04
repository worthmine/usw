use Test::More 0.98 tests => 1;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

use usww;
my $plan = 10;

my $code = qx"cat t/share/01_cp932.txt | $^X t/share/03_cp932.pl >/dev/null 2>&1";
ok defined $code, "succeeded to parse STDIN in utf8"
    or say STDERR $code;

done_testing;
