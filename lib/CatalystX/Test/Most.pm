package CatalystX::Test::Most;
use strictures;
use HTTP::Request::Common ( qw{ GET POST DELETE PUT } );
use Test::More;
use Test::Fatal;
our $AUTHORITY = "cpan:ASHLEY";
our $VERSION = "0.01_02";
our @EXPORT = ( qw{ GET POST DELETE PUT },
                qw{ request ctx_request action_redirect },
                qw{ exception },
                qw{ ctx },
                grep { defined &{$_} } @Test::More::EXPORT );

sub import {
    my ( $package, $app, $args ) = @_;
    my $calling_package = [ caller() ]->[0];

    strictures->import;

    require Catalyst::Test;
    Catalyst::Test->import($app, $args);

    {
        no strict "refs";
        *{"${calling_package}::$_"} = \&{$_} for @EXPORT;
    }
}

# delete is obviously a problem and the rest should maybe be the uc
# anyway and not export the HTTP::Request::Common ones or something new?
#sub get    { request( GET( @_ ) ); }
#sub put    { request( PUT( @_ ) ); }
#sub post   { request( POST( @_ ) ); }
#sub delete { request( DELETE( @_ ) ); }

sub ctx { [ ctx_request(@_) ]->[1] }

1;

__END__

=pod

=head1 Name

CatalystX::Test::Most - test base for unit tests on Catalyst applications.

=head1 Synopsis

...

=head1 Copyright and License

Ashley Pond V. Artistic License 2.0.

=cut
