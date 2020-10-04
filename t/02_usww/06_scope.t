use Test::More 0.98;
use lib 'lib';

BEGIN {
    if ( $^O ne 'MSWin32' ) {
        plan skip_all => 'It is tests for just only Windows';
    } else {
        plan tests => 3;
    }
}

local $SIG{__WARN__} = sub {
    like $_[0], qr/^\QArgument "2:" isn't numeric in addition (+)/,
        , 'warnings pragma DOES work now';
};

no warnings;    # Of course it defaults no, but declare it explicitly

eval { my $a = "2:" + 3; };    # isn't numeric

is $@, '', 'warnings pragma does NOT work yet';

{
    use usww;                      # turn it on
    eval { my $a = "2:" + 3; };    # isn't numeric
}

eval { my $a = "2:" + 3; };        # isn't numeric

is $@, '', 'warnings pragma does NOT work again';

done_testing;
