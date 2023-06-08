use Test::More 0.98 tests => 6;
use Encode::Locale;
use Encode qw(is_utf8 decode encode);
binmode \*STDERR, ":encoding(console_out)";
no utf8;    # Of course it defaults no, but declare it explicitly

my $plain = '宣言なし';
is is_utf8($plain), '', "$plain is NOT decoded yet";

my $string = decode( locale => $plain);
is is_utf8($string), 1, "$string is DECODED manually";

my $encoded = encode( locale => $string);
is is_utf8($encoded), '', "$encoded is now encoded to utf8 again";

use usw;    # turn it on

$plain   = '宣言あり';
$encoded = encode( locale => $plain);
is is_utf8($encoded), '', "$encoded is DECODED automatically";
is is_utf8($plain), 1, "$plain is DECODED automatically"; # does not work well

no utf8;    # turn it off again

$plain = '再び宣言なし';
is is_utf8($plain), '', "$plain is NOT decoded again";

done_testing;
