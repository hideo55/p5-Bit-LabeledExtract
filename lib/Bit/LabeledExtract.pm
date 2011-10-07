package Bit::LabeledExtract;
use strict;
use warnings;
use List::MoreUtils qw/each_array/;
use Carp qw/croak/;
our $VERSION = '0.01';

sub new {
	my ( $class, $labels ) = @_;
	croak "Argument must be ARRAY reference of label string." if !defined($labels) || ( ref($labels) || q{} ) ne 'ARRAY';
	return bless {
		labels     => [@$labels],
		bit_length => scalar @$labels,
	}, $class;
}

sub extract {
	my ( $self, $bits ) = @_;
	my $blen     = $self->{'bit_length'};
	my @bits     = split //, sprintf("%0${blen}b", $bits);
	croak "Bit length unmatched" if scalar(@bits) != $blen;
	my $ea = each_array( @{ $self->{'labels'} }, @bits );
	my @actives;
	while ( my ( $label, $bit ) = $ea->() ) {
		push @actives, $label if $bit;
	}
	return [@actives];
}

1;
__END__

=head1 NAME

Bit::LabeledExtract - Extracts and to label each bit.

=head1 SYNOPSIS

  use Bit::LabeledExtract;
  
  my $ble = Bit::LabeledExtract->new(qw/R W X/);
  my $labels = ble->extract(0x05); # [qw/R X/]

=head1 DESCRIPTION

This module extracts active bits from bits sequence and to label each bit.

=head1 METHODS

=over 4

=item new(¥@labels)

Creates and returns a new Bit::LabeledExtract object.

Argument is ARRAY reference of string that label of bit.

=item extract($bits);

return ARRAY reference of active bit's label.

=back

=head1 AUTHOR

Hideaki Ohno E<lt>hide.o.j55 {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
