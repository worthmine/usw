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

    local $| = 0;

    #binmode \*STDOUT, ':encoding(UTF-8)'; # does NOT need?
    binmode \*STDERR, ':encoding(UTF-8)';
    return;
}

1;
__END__

=encoding utf-8

=head1 NAME

usw - It's new $module

=head1 SYNOPSIS

    use usw;

=head1 DESCRIPTION

usw is ...

=head1 LICENSE

Copyright (C) worthmine.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

worthmine E<lt>worthmine@gmail.comE<gt>

=cut

