package BuyLocal::Controller::Letter;
use Mojo::Base 'Mojolicious::Controller::REST';
use Mojo::Log;
use Data::Dumper;
use Try::Tiny;
use BuyLocal::Schema;

# Log to STDERR
my $log = Mojo::Log->new;

sub create_letter {
    my $self = shift;
    
    #TODO Check for authorization

    #TODO store the letter (coming from Wufoo) in the database
    $log->debug( Dumper( $self->req->body ) );
    
    $self->data( hello => 'world' )->message('Not good');

}

sub read_letter {
    my $self = shift;
    my $id   = $self->param('letterId');

    my $schema   = $self->schema();
    my $letter   = $schema->resultset( 'Letter' )->get_letter($id);
    
    $self->data( letters => $letter )->message('Looks good');

}

sub list_letter {
    my $self = shift;
    my $page   = $self->param('page');
    my $limit   = $self->param('limit');

    my $schema   = $self->schema();
    my $letters   = $schema->resultset( 'Letter' )->get_letters($page, $limit);
    
    $self->data( letters => $letters )->message('Looks good');
}

sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Nothing to see here');
}

1;
