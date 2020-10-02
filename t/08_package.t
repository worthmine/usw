package Some;

use Test::More 0.98 tests => 5;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';
use feature qw(say);

local $SIG{__WARN__} = sub {
    $_[0] =~ /^Wide character in (?:print|say) .* line (\d+)\.$/;
    if ( $1 and $1 == 32 ) {
        fail "it's not a expected flow";
    } else {
        die $_[0];
    }
};

no utf8;    # Of course it defaults no, but declare it explicitly
use strict;
use warnings;

my $plain = '宣言なし';
eval { say $plain } and pass("$plain is a plain");
my $decoded = decode_utf8($plain);
eval { say $decoded } or pass("succeeded to catch an error: $@");
my $encoded = encode_utf8($decoded);
eval { say $encoded } and pass("$encoded is a plain");

require usw;    # turn it on
usw->import;

$plain = '宣言あり';
eval { say $plain } and pass("succeeded to catch an error: $@");

no utf8;        # turn it off again

$plain = '再び宣言なし';
eval { say $plain } and pass("$plain is a plain");

done_testing;
