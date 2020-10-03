use Test::More 0.98;    # tests => 6;
use lib 'lib';

no utf8;                # there is no need to use
use strict;
use warnings;

my $tests = 3;
SKIP: {
    skip "it's NOT a Windows OS", $tests unless $^O eq "MSWin32";
    eval { require Win32 } or die "install 'Win32' module at first", $tests;
    ok my $GetInputCP = sub {&Win32::GetConsoleCP}, "succeed to include GetInputCP()" unless $@;
    my $cp                   = &$GetInputCP();
    my $ENCODING_CONSOLE_OUT = "cp$cp" if $cp;
    ok $ENCODING_CONSOLE_OUT , "succeed to set ENCODING_CONSOLE_OUT";
    if ($ENCODING_CONSOLE_OUT) {
        eval "use usw qw($ENCODING_CONSOLE_OUT)";
        fail "fail to import as a pragma: $@" if $@;
    } else {
        pass "nothing to do";
    }
}

done_testing;
