use Test::More 0.98 tests => 5;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';
use feature qw(say);

no utf8;
use strict;
use warnings;
my $decoded = decode_utf8 'ut8の文字列';

binmode \*STDERR;    # set to default
local $SIG{__WARN__} = \&alt_warn;

eval { say STDERR $decoded } or pass("dies when no binmode");

require usw;         # turn it on
usw->import;
no utf8;

eval { say STDERR $decoded } and pass("when usw was called");
note $@ if $@;

binmode \*STDERR;    # set to default again

eval { say STDERR $decoded } or pass("dies when no binmode");

done_testing;

sub alt_warn {
    $_[0] =~ /^Wide character in (?:print|say) .* line (\d+)\.$/;
    if ( $1 and $1 == 20 ) {
        fail "it's not a expected warn";
    } else {
        pass "succeeded to catch an error: $_[0]";
        die $_[0];
    }
}
