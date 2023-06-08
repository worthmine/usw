use Test::Builder;
use Encode::Locale;
use Encode qw(is_utf8 decode encode);
binmode \*STDERR, ":encoding(console_out)";

use usw;

my $Test = Test::Builder->new();
$Test->plan( tests => 3 );
my $plan = 10;

binmode \*STDIN;    # reset to default
$Test->subtest( 'Before' => \&judgePlain, reader() );

usw->import();      # run this again to set STDIN as ":encoding(UTF-8|cp\d+)";
$Test->subtest( 'Decoded' => \&judgeDecoded, reader() );

binmode \*STDIN;    # reset to default again
$Test->subtest( 'After' => \&judgePlain, reader() );

$Test->done_testing();

exit 0;

sub judgePlain {
    $Test->plan( tests => scalar @_ );
    for ( 1 .. @_ ) {
        local $_ = shift;
        $Test->BAIL_OUT("no length") unless length;
        $Test->ok( is_utf8($_) != 1, $_ );
    }
}

sub judgeDecoded {
    my @in = @_;
    $Test->plan( tests => scalar @in);
    for my $num ( 1 .. @in ) {
        my $byteNum = decode locale => shift @in;
        $Test->BAIL_OUT("no length") unless length $byteNum;
        $Test->ok( is_utf8($byteNum), $_ );
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
        $Test->BAIL_OUT("you have to use pipe");
    }
    return @in;
}
