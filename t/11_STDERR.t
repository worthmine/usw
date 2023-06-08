use Test::More 0.98 tests => 5;
use Encode::Locale;
use Encode qw(is_utf8 decode encode);
use feature qw(say);

no utf8;
use strict;
use warnings;
my $string = decode locale => 'utf8の文字列';

binmode \*STDERR;    # set to default
local $SIG{__WARN__} = \&alt_warn;

eval { say STDERR $string } or pass "dies when no binmode";
note $@ if $@;

require usw;         # turn it on
usw->import;
no utf8;
local $SIG{__WARN__} = \&alt_warn;

eval { say STDERR $string } and pass "when usw was called";
note $@ if $@;

binmode \*STDERR;    # set to default again

eval { say STDERR $string } or pass "dies when no binmode again";
note $@ if $@;

done_testing;

sub alt_warn {
    $_[0] =~ /^Wide character in (?:print|say) .* line (\d+)\.$/;
    if ( $1 and $1 == 22 ) {
        fail "it's not a expected warn";
    } else {
        pass "succeeded to catch an error: $_[0]";
        die $_[0];
    }
}
