use Test::Builder;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use feature qw(say);

use lib 'lib';

use usw;

my $Test = Test::Builder->new();
$Test->plan( tests => 3 );

my $plan = 10;

binmode \*STDIN;    # set to default
$Test->subtest( 'Before' => \&judgePlain, reader() );

binmode \*STDIN, ":encoding(UTF-8)";    # set to decode auto
$Test->subtest( 'Decoded' => \&judgeDecoded, reader() );

binmode \*STDIN;                        # set to default again
$Test->subtest( 'After' => \&judgePlain, reader() );

$Test->done_testing();

exit;

sub judgePlain {
    $Test->plan( tests => scalar @_ );
    for ( 1 .. @_ ) {
        local $_ = shift @_;
        $Test->BAIL_OUT("no length") unless length;
        $Test->is_num( is_utf8($_), !1, $_ );
    }
}

sub judgeDecoded {
    $Test->plan( tests => scalar @_ );
    for ( 1 .. @_ ) {
        local $_ = shift @_;
        $Test->BAIL_OUT("no length") unless length;
        $Test->is_num( is_utf8($_), 1, encode_utf8($_) );    #: fail $_;
    }
}

sub reader {
    my @in = ();
    if (@ARGV) {
        $Test->BAIL_OUT("\@ARGV is set");
    } elsif ( -p STDIN ) {                                   # is a pipe
        for ( 1 .. $plan ) {
            local $_ = <STDIN>;
            chomp if length;
            push @in, $_;
        }
    } else {
        $Test->BAIL_OUT("no data");
    }
    return @in;
}
