use Test::More 0.98 tests => 6;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

local $SIG{__WARN__} = sub {
    is_utf8( $_[0] )
        ? ok 1, encode_utf8( $_[0] ) . " is DECODED"
        : ok 1, "$_[0] is NOT decoded";
};

no utf8;    # Of course it defaults no, but declare it explicitly

warn my $plain   = '宣言なし';
warn my $decoded = decode_utf8($plain);
warn my $encoded = encode_utf8($decoded);

use usw;    # turn it on

warn $plain   = '宣言あり';
warn $encoded = encode_utf8($plain);

no utf8;    # turn it off again

warn $plain = '再び宣言なし';

done_testing;
