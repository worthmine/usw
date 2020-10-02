use Test::More 0.98 tests => 5;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';
use feature qw(say);

local $SIG{__WARN__} = sub {
    $_[0] =~ /^Wide character in (?:print|say) .* line (\d+)\.$/;
    if ( $1 and $1 == 29 ) {
        fail "it's not a expected flow";
    } else {
        pass "succeeded to catch an error: $_[0]";
        die $_[0];
    }
};

no utf8;
use strict;
use warnings;
my $decoded = decode_utf8 'ut8の文字列';

binmode \*STDERR;

eval { say STDERR $decoded } or pass("dies when no binmode");

require usw;    # turn it on
usw->import;
no utf8;

eval { say STDERR $decoded } and pass("setting bimmode automatically");

binmode \*STDERR;    # turn it off again

eval { say STDERR $decoded } or pass("dies when no binmode");

done_testing;
