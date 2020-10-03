use Test::More 0.98 skip_all => "not yet";    # tests => 6;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

no utf8;                                      # Of course it defaults no, but declare it explicitly
use strict;
use warnings;

use lib 't/lib';

my @success = ( 'Ascii.pm', '成功.pm' );
for (@success) {
    eval { require $_ } and pass("$_ is a plain");
    note $@ if $@;
}
{
    use usw;                                  # turn it on
    my @success = ( 'Ascii.pm', '成功.pm' );
    for (@success) {
        my $name = encode_utf8 $_;
        eval { require $_ } and pass("$name is a plain");
        note $@ if $@;
    }
}
for (@success) {
    eval { require $_ } and pass("$_ is a plain");
    note $@ if $@;
}

done_testing;
