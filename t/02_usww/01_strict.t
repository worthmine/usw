use Test::More 0.98;
use lib 'lib';

BEGIN {
    if ( $^O ne 'MSWin32' ) {
        plan skip_all => 'It is tests for just only Windows';
    } else {
        plan tests => 4;
    }
}

no strict;                        # Of course it defaults no, but declare it explicitly
eval q( $inner = 'strings'; );    # missing to declare with `my`
is $@, '', "Successfully ignored a declaration without `my`";

use usww;                         # turn it on

my $outer = eval q( $inner = 'strings'; );    # with no `my`
is $outer, undef, "Successfully failed to evaluate";
like $@,
    qr/^Global symbol "\$inner" requires explicit package name/,
    "Successfully detected a declaration missing `my`";

no strict;                                    # turn it off again

eval q( $inner = 'strings'; );                # missing to declare with C<my>
is $@, '', "Successfully ignored a declaration without `my`";

done_testing;
