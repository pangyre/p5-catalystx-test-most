package CatalystX::Test::Most;
use strictures;
use HTTP::Request::Common ( qw{ GET POST DELETE PUT } );
use Test::More;
use Test::Fatal;
our $AUTHORITY = "cpan:ASHLEY";
our $VERSION = "0.03";
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

CatalystX::Test::Most - Test base pulling in L<Catalyst::Test>, L<Test::More>, L<Test::Fatal>, and L<HTTP::Request::Common> for unit tests on Catalyst applications.

=head1 Synopsis

 use CatalystX::Test::Most "MyApp";
 ok request("/")->is_success, "/ is okay";
 is exception { request("/no-such-uri") }, undef,
    "404s do not throw exceptions";
 is request("/no-such-uri")->code, 404, "And do return 404";
 done_testing();

 # ok 1 - / is okay
 # ok 2 - 404s do not throw exceptions
 # ok 3 - And do return 404
 # 1..3

=head1 Exported Functions from Other Packages

=head2 Catalyst::Test

Everything, so see its documentaiton: L<Catalyst::Test>. L<CatalystX::Test::Most> is basically and overloaded version of it.

=head2 Test::More

All of its exported functions; see its documentation: L<Test::More>.

=head2 Test::Fatal

See C<exception> in L<Test::Fatal>.

=head1 New Function

=over 4

=item * C<ctx>

This is a wrapper to get the context object. It will only work on local tests (not remote servers).

=back

=head1 Notes

L<strictures> are exported.

=head1 Copyright and License

Ashley Pond V. Artistic License 2.0.

=cut
