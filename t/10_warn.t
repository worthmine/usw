use Test::More 0.98 tests => 8;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';
use feature qw(say);
use List::Util qw(first);
$SIG{__WARN__} = sub {
    $_[0] =~ /^Wide character in (?:print|say) .* line (\d+)\.$/;
    is_utf8( $_[0] )
        ? die encode_utf8 $_[0]
        : pass("plain text $1 was warned");
};
local $SIG{__DIE__} = sub {
    $_[0] =~ /line (\d+)\.$/;
    if ( $1 == 37 ) {
        note "it's a expected flow: $1";
    }
};

no utf8;    # Of course it defaults no, but declare it explicitly
use strict;
use warnings;

my $plain = '宣言なし';
eval { warn $plain } and pass("$plain is a plain");
my $decoded = decode_utf8($plain);
eval { warn $decoded } or pass("fail to die with decoded warns");
my $encoded = encode_utf8($decoded);
eval { warn $encoded } and pass("$encoded is a plain");

require usw;    # turn it on
usw->import;

use usw;

$plain = '宣言あり';

eval { warn $plain } or pass("pass to warn with decoded strings");

no utf8;        # turn it off again

$plain = '再び宣言なし';
eval { warn $plain } and pass("$plain is a plain");

done_testing;
