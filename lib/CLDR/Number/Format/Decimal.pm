package CLDR::Number::Format::Decimal;

use utf8;
use Moo;
use Carp;
use Scalar::Util qw( looks_like_number );

our $VERSION = '0.00';

with qw( CLDR::Number::Role::Format );

has infinity => (
    is => 'rw',
);

has nan => (
    is => 'rw',
);

after _trigger_locale => sub {
    my ($self) = @_;

    $self->_build_attributes;
};

sub BUILD {
    my ($self) = @_;

    $self->_build_attributes;
}

sub _build_attributes {
    my ($self) = @_;

    $self->pattern(  $self->_get_data(patterns => 'decimal'  ) );
    $self->infinity( $self->_get_data( symbols => 'infinity' ) );
    $self->nan(      $self->_get_data( symbols => 'nan'      ) );
}

sub format {
    my ($self, $num) = @_;

    return $self->_format_number($num);
}

1;

=encoding UTF-8

=head1 NAME

CLDR::Number::Format::Decimal - Decimal formatter using the Unicode CLDR

=head1 SYNOPSIS

    # either
    use CLDR::Number::Format::Decimal;
    my $decf = CLDR::Number::Format::Decimal->new(locale => 'es');

    # or
    use CLDR::Number;
    my $cldr = CLDR::Number->new(locale => 'es');
    my $decf = $cldr->decimal_formatter,

    $decf->format(1337)   # 1.337
    $decf->format(-1337)  # -1.337

    $decf->locale('en');
    $decf->minimum_fraction_size(3);
    $decf->format(1337)  # 1,337.000

=head1 ATTRIBUTES

=over

=item infinity

=item nan

=back

=head1 METHODS

=over

=item format

=item at_least

=item range

=back

=head1 AUTHOR

Nick Patch <patch@cpan.org>

=head1 COPYRIGHT AND LICENSE

© 2013 Nick Patch

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.
