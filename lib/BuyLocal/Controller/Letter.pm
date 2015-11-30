package BuyLocal::Controller::Letter;
use Mojo::Base 'Mojolicious::Controller::REST';
use Mojo::Log;
use Mojo::Util qw(url_escape url_unescape trim squish encode);
use Data::Dumper;
use Try::Tiny;
use BuyLocal::Schema;

# Log to STDERR
my $log = Mojo::Log->new;

sub create_letter {
    my $self   = shift;
    my $config = $self->config;

    return $self->status( '401' )
        unless $self->param( 'HandshakeKey' ) eq $config->{'handshakekey'};

    my $entry = {
        id            => $self->param( 'EntryId' ),
        date_created  => $self->param( 'DateCreated' ),
        first_name    => $self->param( 'Field1' ),
        last_name     => $self->param( 'Field2' ),
        email         => $self->param( 'Field3' ),
        business_name => $self->param( 'Field7' ),
        business_city => $self->param( 'Field8' ),
        business_url  => $self->param( 'Field122' ),
        letter_text   => $self->param( 'Field5' ),
        public_name   => $self->param( 'Field11' )
    };

    my $result = $self->find_or_new( $entry );

    $self->data( id => $result->id )->message( 'New record created' )
        ->status( '200' );
}

sub read_letter {
    my $self = shift;
    my $id   = $self->param( 'letterId' );

    my $schema = $self->schema();
    my $letter = $schema->resultset( 'Letter' )->get_letter( $id );
    if ( $letter ) {
        $self->data( letters => $letter )->message( 'Looks good' );
    }
    else {
        $self->status( '422' )->message( 'Entry does not exist' );
    }
}

sub list_letter {
    my $self  = shift;
    my $page  = $self->param( 'page' );
    my $limit = $self->param( 'limit' );
    my $query = $self->param( 'query' );
    $query    = squish $query;

    my $schema = $self->schema();
    my $letters
        = $schema->resultset( 'Letter' )->get_letters( $page, $limit, $query );

    $self->data( letters => $letters, query => $query )->message( 'Looks good' );
}

sub welcome {
    my $self = shift;

    # Render template "example/welcome.html.ep" with message
    $self->render( msg => 'Nothing to see here' );
}

1;
