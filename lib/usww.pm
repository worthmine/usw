package usww;
use 5.012005;

die "it seems this is NOT Windows" unless $^O eq "MSWin32";

our $VERSION = "0.04";

use Encode qw(is_utf8 encode_utf8 decode_utf8);
use utf8();
use strict();
use warnings();
use List::Util qw(first);

sub import {
    utf8->import;
    strict->import;
    warnings->import( 'all', FATAL => 'recursion' );

    my $cp = eval { require Win32; Win32::GetConsoleCP() }
        or die "install 'Win32' module before use it";
    my $encoding = $@ ? 'UTF-8' : "cp$cp";
    binmode \*STDIN,  ":encoding($encoding)";
    binmode \*STDOUT, ":encoding($encoding)";
    binmode \*STDERR, ":encoding($encoding)";

    $SIG{__WARN__} = \&_redecode;
    $SIG{__DIE__}  = sub { die _redecode(@_) };
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

usww - use utf8; use strict; use warnings; in one line on Windows.

=head1 SYNOPSIS

 use usww; # is just 9 bytes pragma instead of below:
 use utf8;
 use strict;
 use warnings;
 my $cp = '__YourCP__' || 'UTF-8';
 binmode \*STDIN,  ':encoding($cp)';
 binmode \*STDOUT, ':encoding($cp)';
 binmode \*STDERR, ':encoding($cp)';
  
=head1 DESCRIPTION

usww is C<usw> for Windows.

May be useful for those who write the above code every single time with Windows.

=head2 HOW TO USE

 use usww;

It seems a kind of pragmas but doesn't spent
L<%^H|https://metacpan.org/pod/perlpragma#Key-naming>
because overusing it is nonsense.

C<use usww;> should be just the very shortcut at beginning of your codes

Therefore, if you want to set C<no>, you should do it the same way as before.

 no strict;
 no warnings;
 no utf8;

These still work as expected everywhere.

And writing like this doesn't work

 no usww;

=head2 Automatically repairs potential bugs around encoding  

It replaces C<$SIG{__WARN__}> or/and C<$SIG{__DIE__}>
to avoid the bug(This may be a strange specification)
of encoding only the file path like that:

 宣言あり at t/script/00_è­¦åãã.pl line 19.

=head1 SEE ALSO

L<usw> 
L<Encode>
L<binmode|https://perldoc.perl.org/functions/binmode>
L<%SIG|https://perldoc.perl.org/variables/%25SIG>
L<Win32>

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida(L<worthmine|https://github.com/worthmine>)

=cut
