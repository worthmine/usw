use Test::More 0.98 tests => 3;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

use usw;
my $plan = 10;

binmode \*STDIN;    # set to default
subtest 'Before' => \&judgePlain, reader();

binmode \*STDIN, ":encoding(UTF-8)";    # set to decode auto
subtest 'Decoded' => \&judgeDecoded, reader();

binmode \*STDIN;                        # set to default again
subtest 'After' => \&judgePlain, reader();

done_testing;

sub judgePlain {
    plan tests => scalar @_;
    for ( 1 .. @_ ) {
        local $_ = shift @_;
        fail "no length" or last unless length;
        is_utf8($_) ? fail encode_utf8($_) : pass $_;
    }
}

sub judgeDecoded {
    plan tests => scalar @_;
    for ( 1 .. @_ ) {
        local $_ = shift @_;
        fail "no length" or last unless length;
        is_utf8($_) ? pass encode_utf8($_) : fail $_;
    }
}

sub reader {
    my @in = ();
    if (@ARGV) {
        fail "\@ARGV is set";
    } elsif ( -p STDIN ) {    # is a pipe
        for ( 1 .. $plan ) {
            local $_ = <STDIN>;
            chomp if length;
            push @in, $_;
        }
    } else {
        fail "no data";
    }
    return @in;
}
