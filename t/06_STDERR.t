use Test::More 0.98 tests => 6;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';
use feature qw(say);

my $qr = qr/^Wide character/;
local $SIG{__WARN__} = sub {
    like $_[0], $qr, "succeeded to catch an error: $_[0]";
};

no utf8;
use strict;
use warnings;
my $plain = decode_utf8 'ut8の文字列';
binmode \*STDERR;

say STDERR $plain and pass("no binmode");

use usw;    # turn it on

say STDERR $plain and pass("when use usw;");

binmode \*STDERR;    # turn it off again

say STDERR $plain and pass("no binmode");

done_testing;
