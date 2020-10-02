use Test::More 0.98 tests => 3;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use lib 'lib';

my @array = qw(0 1 2 3 4 5 6 7 8 9);

$SIG{__WARN__} = sub {
    like $_[0], qr/^\QArgument "2:" isn't numeric in addition (+)/,
        , 'warnings pragma DOES work now';
};

subtest 'Before package' => \&test4off;

package Some {
    use Test::More 0.98;
    use Encode qw(is_utf8 encode_utf8 decode_utf8);
    use usw;    # turn it on
    subtest 'Inner package' => sub {
        my $outer = eval q( $inner = 'strings'; );    # with no `my`
        is( defined $outer, '', "successfully failed to evaluate" );

        eval { my $a = "2:" + 3; };                   # isn't numeric

        my $plain   = '宣言あり';
        my $encoded = encode_utf8($plain);
        is is_utf8($plain), 1, "$encoded is DECODED automatically";
    };
}

subtest 'After package' => \&test4off;

done_testing;

sub test4off {
    plan tests => 3;
    no strict;    # Of course it defaults no, but declare it explicitly
    no warnings;
    no utf8;

    eval q( $inner = 'strings'; );    # missing to declare with `my`
    is $@, '', "Successfully ignored a declaration without `my`";

    local $SIG{__WARN__} = sub {
        like $_[0], qr/^\QArgument "2:" isn't numeric in addition (+)/,
            , 'warnings pragma DOES work now';
    };

    eval { my $a = "2:" + 3; };       # isn't numeric

    is $@, '', 'warnings pragma does NOT work yet';

    my $plain = '宣言なし';
    is is_utf8($plain), '', "$plain is NOT decoded yet";
}
