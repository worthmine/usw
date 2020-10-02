use Test::More 0.98 tests => 6;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';
use feature qw(say);
use List::Util qw(first);
$SIG{__WARN__} = sub {
    use usw;
    $_[0] =~ /(.+) line (\d+)\.$/;
    return pass("plain text $1 was warned") unless is_utf8($1);
    my $encoded = encode_utf8 $_[0];
    if ( $_[0] =~ qr/^宣言/ ) {
        fail "code is broken" if $encoded ne '\u{5BA3}\u{8A00}\u{3042}\u{308A}';
        pass "it's an expected warning: $encoded";
    } else {
        fail "it's an unexpected warning: $encoded";
    }
};

no utf8;    # Of course it defaults no, but declare it explicitly
use strict;
use warnings;

note "these tests have always passed";

my $plain = '宣言なし';
eval { warn $plain } and pass("$plain is a plain");

{
    use usw;    # turn it on
    my $decoded = '宣言あり';
    eval { warn encode_utf8 $decoded } and pass("pass to warn with decoded strings");
}

eval { warn $plain } and pass("$plain is a plain");

done_testing;
