use Test::More 0.98 tests => 3;

my $expression = q{ my $a = "2:" + 3; };
local $SIG{__WARN__} = sub {
    like $_[0], qr/^\QArgument "2:" isn't numeric in addition (+)/,
        , 'warnings pragma DOES work now';
};

no warnings;    # Of course it defaults no, but declare it explicitly
eval $expression;    # isn't numeric
is $@, '', 'warnings pragma does NOT work yet';

use usw;                       # turn it on
eval $expression;    # isn't numeric

no warnings;                   # turn it off again
eval $expression;    # isn't numeric
is $@, '', 'warnings pragma does NOT work again';

done_testing;
