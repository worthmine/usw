use Test::More 0.98 tests => 6;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

local $SIG{__DIE__} = sub {
    is_utf8( $_[0] )
        ? ok 1, encode_utf8( $_[0] ) . " is DECODED"
        : ok 1, "$_[0] is NOT decoded";
};

no utf8;    # Of course it defaults no, but declare it explicitly

my $plain = '宣言なし';
eval { die $plain };
my $decoded = decode_utf8($plain);
eval { die $decoded };
my $encoded = encode_utf8($decoded);
eval { die $encoded };

use usw;    # turn it on

$plain = '宣言あり';
eval { die $plain };
$encoded = encode_utf8($plain);
eval { die $encoded };

no utf8;    # turn it off again

$plain = '再び宣言なし';
eval { die $plain };

done_testing;
