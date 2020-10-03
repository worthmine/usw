use Test::More 0.98 tests => 6;
use lib 'lib';

no utf8;    # Of course it defaults no, but declare it explicitly

use strict;
use warnings;

use lib 't/lib';

eval "use Ascii" and pass("Ascii is a plain");
eval "use 成功"    and fail("成功 is a plain");

{
    use usw;    # turn it on
    eval "use Ascii" and pass("Ascii is a plain");
    eval "use 成功"    and fail("成功 is a plain");
}

eval "use Ascii" and pass("Ascii is a plain");
eval "use 成功"    and fail("成功 is a plain");

done_testing;
