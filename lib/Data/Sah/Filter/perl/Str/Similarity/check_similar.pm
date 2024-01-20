package Data::Sah::Filter::perl::Str::Similarity::check_similar;

use 5.010001;
use strict;
use warnings;

use Data::Dmp;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    +{
        v => 1,
        summary => 'Check that string is similar to a reference string',
        might_fail => 1,
        args => {
            str => {schema=>'str*', req=>1},
            algo => {schema=>'str*', in=>['editdist']},
            threshold => {schema=>'float*'},
        },
        examples => [
        ],
    };
}

sub filter {
    my %fargs = @_;

    my $dt = $fargs{data_term};
    my $gen_args = $fargs{args} // {};

    my $res = {};
    $res->{expr_filter} = join(
        "",
        "do { ", (
            "my \$tmp = $dt; my \$from_pat = ", dmp($gen_args->{from_pat}), "; my \$to_str = ", dmp($gen_args->{to_str}), "; ",
            "\$tmp =~ s/\$from_pat/\$to_str/g; ",
            "\$tmp ",
        ), "}",
    );

    $res;
}

1;
# ABSTRACT:

=for Pod::Coverage ^(meta|filter)$

=head1 SEE ALSO
