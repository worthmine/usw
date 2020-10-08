use Test::More 0.98 tests => 1;
use Encode qw(is_utf8 encode_utf8 decode_utf8);
use Data::Dumper::AutoEncode qw(-dumper);

use usw;
note my $dump = Dumper my $decoded = '宣言あり';
like decode_utf8($dump), qr/'$decoded';$/, "succeeded to encode in auto";

done_testing;
