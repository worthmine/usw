#!/usr/env perl

use feature qw(say state);
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

no utf8;
use strict;
use warnings;

swicth(0);
my $text = '宣言なし';
eval { warn $text } or say("pass to warn with plain text");
say decode_utf8 $@ if $@;

use usw qw(warn);
swicth(1);
$text = '宣言あり';
eval { warn $text } or say("pass to warn with decoded text");
say $@ if $@;

no utf8;
swicth(0);
$text = '再び宣言なし';
eval { warn $text } or say("pass to warn with plain text");
say decode_utf8 $@ if $@;

exit;

sub swicth {
    my $flag = shift || 0;
    state $keep = $SIG{__WARN__};
    $SIG{__WARN__}
        = $flag
        ? sub { die &$keep( $_[0] ) }
        : sub { die $_[0] };
}
