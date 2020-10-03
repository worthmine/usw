package usw;
use 5.012005;

our $VERSION = "0.02";

use Encode qw(is_utf8 encode_utf8 decode_utf8);
use utf8();
use strict();
use warnings();
use List::Util qw(first);

sub import {
    utf8->import;
    strict->import;
    warnings->import( 'all', FATAL => 'recursion' );

    #my $in  = 'UTF-8';

    my $out = first { $_ =~ /^cp\d+$/ } @_;
    $out ||= 'UTF-8';

    binmode \*STDOUT, ":encoding($out)";
    binmode \*STDERR, ":encoding($out)";
    return unless @_;

    $SIG{__WARN__} = \&_redecode if first { $_ eq 'warn' } @_;
    $SIG{__DIE__}  = sub { die _redecode(@_) }
        if first { $_ eq 'die' } @_;

    return;
}

sub _redecode {
    $_[0] =~ /^(.+) at (.+) line (\d+)\.$/;
    my @texts = split $2, $_[0];
    return is_utf8($1)
        ? $texts[0] . decode_utf8 $2. $texts[1]
        : decode_utf8 $_[0];
}

1;

__END__

=encoding utf-8

=head1 NAME

usw - use utf8; use strict; use warnings; in one line.

=head1 SYNOPSIS

 use usw; # is just 8 bytes pragma instead of below:
 use utf8;
 use strict;
 use warnings;
 binmode \*STDOUT, ':encoding(UTF-8)';
 binmode \*STDERR, ':encoding(UTF-8)';
  
=head1 DESCRIPTION

usw is a shortcut pragma mostly for one-liners.

May be useful for those who write the above code every single time

=head2 HOW TO USE

  use usw;

It seems a kind of pragmas but doesn't spent
L<%^H|https://metacpan.org/pod/perlpragma#Key-naming>
because overusing it is nonsense.

C<use usw;> should be just the very shortcut at beginning of your codes

Therefore, if you want to set C<no>, you should do it the same way as before.

 no strict;
 no warnings;
 no utf8;

These still work as expected everywhere.

And writing like this doesn't work

 no usw;

=head2 OPTIONS

Since version 0.03, you can write like this:

 use usw qw(warn die);

These options replaces C<$SIG{__WARN__}> or/and C<$SIG{__DIE__}>
to avoid the bug(This may be a strange specification)
of encoding only the file path like that:

 宣言あり at t/script/00_è­¦åãã.pl line 19.

This import is B<only> if written.

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida(L<worthmine|https://github.com/worthmine>)

=cut
