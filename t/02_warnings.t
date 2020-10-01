use Test::More 0.98 tests => 3;
use lib 'lib';

my @array = qw(0 1 2 3 4 5 6 7 8 9);

local $SIG{__WARN__} = sub {
    like $_[0], qr/^Scalar value \@array\[0\] better written as \$array\[0\]/,
        , 'warnings pragma DOES work now';
};

no warnings;    # Of course it defaults no, but declare it explicitly
eval <<'EOL';
    my $head = @array[0];    # correctly, be $array[0];
EOL
is $@, '', 'warnings pragma does NOT work yet';

use usw;         # turn it on
eval <<'EOL';    # it calls $SIG{__WARN__};
    my $head = @array[0];    # correctly, be $array[0];
EOL

no warnings;     # turn it off again
eval <<'EOL';
    my $head = @array[0];    # correctly, be $array[0];
EOL
is $@, '', 'warnings pragma does NOT work again';

done_testing;
