package usw;
use 5.008001;

our $VERSION = "0.01";

use Encode qw(encode_utf8 decode_utf8);
use strict();
use warnings();
use utf8();

sub import {
    strict->import;
    warnings->import( 'all', FATAL => 'recursion' );
    utf8->import;

    binmode \*STDOUT, ':encoding(UTF-8)';
    binmode \*STDERR, ':encoding(UTF-8)';
    return;
}

1;
__END__

=encoding utf-8

=head1 NAME

usw - use utf8; use strict; use warnings; In one line.

=head1 SYNOPSIS

 use usw; # is just 8 bytes pragma instead of below:
 use utf8;
 use strict;
 use warnings;
 binmode \*STDOUT, ':encoding(UTF-8)';
 binmode \*STDERR, ':encoding(UTF-8)';
  
=head1 DESCRIPTION

usw is a shortcut mainly for one-liner.

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yuki Yoshida(L<worthmine|https://github.com/worthmine>)

=cut
