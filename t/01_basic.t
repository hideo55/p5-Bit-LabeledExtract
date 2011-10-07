use strict;
use Test::More;
use Bit::LabeledExtract;
use Test::Fatal;

my $bits = Bit::LabeledExtract->new([qw/READABLE WRITABLE EXECUTABLE/]);

my $res;

$res = $bits->extract(0x04);
is_deeply($res, [qw/READABLE/]);

$res = $bits->extract(0x05);
is_deeply($res, [qw/READABLE EXECUTABLE/]);

$res = $bits->extract(0x07);
is_deeply($res, [qw/READABLE WRITABLE EXECUTABLE/]);

$res = $bits->extract(0x00);
is_deeply($res, []);

like(exception{ $bits->extract(0x08); }, qr/^Bit length unmatched/, 'bit length unmatch');

done_testing;
__END__
