package usw;
use 5.012005;
use parent qw(utf8 strict warnings);
use Encode::Locale;
use Encode qw(is_utf8 decode encode);

our $VERSION = "0.12";
use parent qw(Exporter);
our @EXPORT = qw( is_utf8 decode encode);
sub get_encoding_locale { $Encode::Locale::ENCODING_LOCALE || 'UTF-8' }

sub import {
    $_->import for qw( utf8 strict warnings );   # borrowed from https://metacpan.org/pod/Mojo::Base
    $| = 1;
    if (-t) {
        binmode \*STDIN  => ":encoding(console_in)";
        binmode \*STDOUT => ":encoding(console_out)";
        binmode \*STDERR => ":encoding(console_out)";
    }else{
        binmode "\\*$_" => ":encoding(locale)" for  qw(STDIN STDOUT STDERR);
   }

    $SIG{__WARN__} = \&_redecode;
    $SIG{__DIE__}  = sub { die _redecode(@_) };
    return;
}

sub unimport {
    require Carp;
    Carp::croak "$_[0] doesn't provide `no` pragma";
}

sub _redecode {
    $_[0] =~ /^(.+) at (.+) line (\d+)\.$/;
    my @texts = split $2, $_[0];
    return is_utf8($1)
        ? $texts[0] || '' . decode( locale => $2 ) . $texts[1] || ''
        : decode locale => $_[0];
}

1;

__END__

=encoding utf-8

=head1 NAME

usw - use utf8; use strict; use warnings; in one line.

=head1 SYNOPSIS

 use usw; # is like just 8 bytes pragma that works instead of below:
 use utf8;
 use strict;
 use warnings;
 use Encode qw(is_utf8 decode encode);
 my $cp = '__YourCP__' || 'UTF-8';
 binmode \*STDIN,  ':encoding($cp)';
 binmode \*STDOUT, ':encoding($cp)';
 binmode \*STDERR, ':encoding($cp)';
  
=head1 DESCRIPTION

usw is like a shortcut pragma that works in any environment.

May be useful for those who write the above code every single time.

=head2 HOW TO USE

 use usw;

It seems a kind of pragmas but doesn't spent
L<%^H|https://metacpan.org/pod/perlpragma#Key-naming>
because overusing it is nonsense.

C<use usw;> should be just the very shortcut at beginning of your codes.

Therefore, if you want to set C<no>, you should do it the same way as before.

 no strict;
 no warnings;
 no utf8;

These still work as expected everywhere.

And writing like this doesn't work.

 no usw;

Since version 0.12, it dies with warning.

=head2 Automatically repairs bugs around file path which is encoded

It replaces C<$SIG{__WARN__}> or/and C<$SIG{__DIE__}>
to avoid the bug(This may be a strange specification)
of encoding only the file path like that:

 宣言あり at t/script/00_è­¦åãã.pl line 19.

=head2 features
Since version 0.13, you don't have to insert C<use Encode qw(is_utf8 decode encode);> in your code.

Since version 0.08, you don't have to care if the environment is a Windows or not.

Since version 0.07, you can asign to C<STDIN>,C<STDOUT>,C<STDERR>
with which is detected automatically.


=head1 SEE ALSO

=over

=item L<Encode>

=item L<binmode|https://perldoc.perl.org/functions/binmode>

=item L<%SIG|https://perldoc.perl.org/variables/%25SIG>

=item L<Win32>

=item L<open>

=back

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida(L<worthmine|https://github.com/worthmine>)

=cut
