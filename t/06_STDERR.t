use Test::More 0.98 tests => 6;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';
use feature qw(say);

local $SIG{__WARN__} = sub {
    like $_[0], qr/^Wide character/, "succeeded to catch an error: $_[0]";
};

use utf8;
use strict;
use warnings;
binmode \*STDERR, '';

say STDERR my $plain = "宣言なし" and pass("no binmode");
eval { say STDERR decode_utf8($plain) } or warn $@;

use usw;    # turn it on

say STDERR $plain = "宣言あり" and pass("when use usw;");
eval { say STDERR decode_utf8($plain) } or warn $@;

binmode \*STDERR, '';    # turn it off again

say STDERR $plain = "再び宣言なし" and pass("no binmode");
eval { say STDERR decode_utf8($plain) } or warn $@;

done_testing;
