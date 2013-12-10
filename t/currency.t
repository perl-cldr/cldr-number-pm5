use utf8;
use strict;
use warnings;
use open qw( :encoding(UTF-8) :std );
use Test::More tests => 12;
use Test::Exception;
use CLDR::Number;

my ($cldr, $curf, $decf);

$cldr = CLDR::Number->new;
$curf = $cldr->currency_formatter;
throws_ok { $curf->format(1.99) } qr{Missing required attribute: currency_code};

$cldr = CLDR::Number->new(locale => 'sv');
is $cldr->decimal_sign, ',', 'Swedish decimal from format generator';

$decf = $cldr->decimal_formatter;
is $decf->decimal_sign, ',', 'Swedish decimal from decimal formatter';
is $decf->format(1.99), '1,99', 'formatted Swedish decimal';

$curf = $cldr->currency_formatter(currency_code => 'SEK');
is $curf->decimal_sign, ':', 'Swedish currency decimal from currency formatter';
is $curf->format(1.99), '1:99 kr', 'formatted Swedish currency';

$curf = $cldr->currency_formatter(
    locale                  => 'en',
    currency_code           => 'USD',
    maximum_fraction_digits => 0,
);

is $curf->maximum_fraction_digits, 0, 'max frac digits spared by currency code';
is $curf->format(10), '$10',          'max frac digits spared by currency code';

$curf = $cldr->currency_formatter(
    locale        => 'en',
    currency_code => 'USD',
    pattern       => '¤00',
);

is $curf->pattern,   '¤00', 'pattern spared by locale on create';
is $curf->format(5), '$05', 'pattern spared by locale on create';

$curf = $cldr->currency_formatter(
    locale        => 'en',
    currency_code => 'USD',
    currency_sign => '!!!',
);

is $curf->currency_sign, '!!!', 'sign spared by currency code on create';
is $curf->format(5), '!!!5.00', 'sign spared by currency code on create';
