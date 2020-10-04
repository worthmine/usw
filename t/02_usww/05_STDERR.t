use Test::More 0.98;
use feature qw(say);
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

BEGIN {
    if ( $^O ne 'MSWin32' ) {
        plan skip_all => 'It is tests for just only Windows';
    } else {
        plan tests => 5;
    }
}

no utf8;
use strict;
use warnings;
my $decoded = decode_utf8 'STDERRのテスト';

binmode \*STDERR;    # set to default
local $SIG{__WARN__} = \&alt_warn;

eval { say STDERR $decoded } or pass("dies when no binmode");
note encode_utf8 $@ if $@;

require usww;        # turn it on
usww->import;
no utf8;

eval { say STDERR $decoded } and pass("when usww was called");
note encode_utf8 $@ if $@;

binmode \*STDERR;    # set to default again

eval { say STDERR $decoded } or pass("dies when no binmode");
note encode_utf8 $@ if $@;

done_testing;

sub alt_warn {
    $_[0] =~ /^Wide character in (?:print|say) .* line (\d+)\.$/;
    if ( $1 and $1 == 29 ) {
        fail "it's not a expected warn";
    } else {
        pass "succeeded to catch an error: $_[0]";
        die $_[0];
    }
}
