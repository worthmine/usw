use Test::More 0.98;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

BEGIN {
    if ( $^O ne 'MSWin32' ) {
        plan skip_all => 'It is tests for just only Windows';
    } else {
        plan tests => 6;
    }
}

no utf8;    # Of course it defaults no, but declare it explicitly
use strict;
use warnings;

my $keep = $SIG{__DIE__};
local $SIG{__DIE__} = sub { die &$keep };

my $plain = '宣言なし';
eval { die $plain } or pass("$plain is a plain");
pass encode_utf8 $@ if $@;
{
    use usww qw(die);    # turn it on
    my $keep = $SIG{__DIE__};
    local $SIG{__DIE__} = sub { die &$keep };
    my $decoded = '宣言あり';
    eval { die $decoded } or pass("pass to die with decoded text");
    pass encode_utf8 $@ if $@;
}

eval { die $plain } or pass("$plain is a plain");
pass encode_utf8 $@ if $@;

done_testing;
