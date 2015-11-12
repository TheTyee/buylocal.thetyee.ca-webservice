package BuyLocal;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->plugin('JSONConfig');
    $self->plugin( 'REST' => { prefix => 'api', version => 'v1' } );

    my $config = $self->config;
    $self->helper(schema => sub {
            my $schema = BuyLocal::Schema->connect( $config->{'pg_dsn'},
                $config->{'pg_user'}, $config->{'pg_pass'}, );
            return $schema;
        });

    # Router
    my $r = $self->routes;
    # REST routing
    $r->rest_routes( name => 'Letter', methods => 'crudl' );

    # Normal route to controller
    $r->get('/')->to('letter#welcome');
}

1;
