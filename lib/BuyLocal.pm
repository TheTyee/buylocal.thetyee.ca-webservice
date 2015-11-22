package BuyLocal;
use Mojo::Base 'Mojolicious';
use Mojo::Log;
use Data::Dumper;
use Try::Tiny;
use BuyLocal::Schema;

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->plugin('JSONConfig');
    $self->plugin( 'REST' => { prefix => 'api', version => 'v1' } );
    $self->plugin('SecureCORS');
    $self->plugin('SecureCORS', { max_age => undef });
    # TODO set this to a sensible value
    $self->routes->to('cors.origin' => '*');


    my $config = $self->config;
    # Log to STDERR
    my $log = Mojo::Log->new;

    $self->helper(schema => sub {
            my $schema = BuyLocal::Schema->connect( $config->{'pg_dsn'},
                $config->{'pg_user'}, $config->{'pg_pass'}, { pg_enable_utf8 => 1 } );
            return $schema;
        });

    $self->helper(find_or_new => sub {
            my $self  = shift;
            my $entry = shift;
            my $schema  = $self->schema();
            my $result;
            try {
                $result = $schema->txn_do(
                    sub {
                        my $rs = $schema->resultset( 'Letter' )
                        ->find_or_new( {%$entry} );
                        unless ( $rs->in_storage ) {
                            $rs->insert;
                        }
                        return $rs;
                    }
                );
            }
            catch {
                $log->warn( $_ );
            };
            return $result;
        });

    # Router
    my $r = $self->routes;
    # REST routing
    $r->rest_routes( name => 'Letter', methods => 'crudl' );
    $r->rest_routes( name => 'Business', methods => 'rl' );

    # Normal route to controller
    $r->get('/')->to('letter#welcome');
}

1;
