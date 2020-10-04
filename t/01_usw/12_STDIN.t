use Test::More 0.98;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

use usw;

my $code = qx"cat t/share/00_utf8.txt | $^X t/share/02_utf8.pl >/dev/null 2>&1";
ok defined $code, "succeeded to parse STDIN in utf8"
    or say STDERR $code;

done_testing;
