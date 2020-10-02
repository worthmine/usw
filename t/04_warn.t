use Test::More 0.98 tests => 8;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';
use feature qw(say);

$SIG{__WARN__} = sub {
    $_[0] =~ /(.+) at t\/04_warn\.t line \d+\.$/;
    is_utf8( $_[0] )
        ? die encode_utf8 $_[0]
        : pass("plain text $1 was warned");
};
local $SIG{__DIE__} = sub {
    $_[0] =~ /line (\d+)\.$/;
    if ($1) {
        note "died at line $1";
    } else {
        fail "it's not a expected flow: $_[0]";
    }
};

no utf8;    # Of course it defaults no, but declare it explicitly
use strict;
use warnings;

my $plain = '宣言なし';
eval { warn $plain } and pass("$plain is a plain");
my $decoded = decode_utf8($plain);
eval { warn $decoded } or pass("succeeded to die with decoded warns");
my $encoded = encode_utf8($decoded);
eval { warn $encoded } and pass("$encoded is a plain");

require usw;    # turn it on
usw->import;

$plain = '宣言あり';
eval { warn $plain } or pass("succeeded to die with decoded warns");

no utf8;        # turn it off again

$plain = '再び宣言なし';
eval { warn $plain } and pass("$plain is a plain");

done_testing;
