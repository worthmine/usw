#!/usr/env perl

use feature qw(say state);
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

no utf8;
use strict;
use warnings;

swicth(0);
my $text = '宣言なし';
eval { die $text } or say("pass to die with plain text");
say decode_utf8 $@ if $@;

use usw qw(die);
swicth(1);
$text = '宣言あり';
eval { die $text } or say("pass to die with decoded text");
say $@ if $@;

no utf8;
swicth(0);
$text = '再び宣言なし';
eval { die $text } or say("pass to die with plain text");
say decode_utf8 $@ if $@;

exit;

sub swicth {
    my $flag = shift || 0;
    state $keep = $SIG{__DIE__};
    $SIG{__DIE__}
        = $flag
        ? sub { return &$keep( $_[0] ) }
        : sub { return $_[0] };
}
