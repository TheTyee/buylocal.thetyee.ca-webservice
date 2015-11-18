package BuyLocal::Controller::Business;
use Mojo::Base 'Mojolicious::Controller::REST';
use Mojo::Log;
use Data::Dumper;
use Try::Tiny;
use BuyLocal::Schema;

# Log to STDERR
my $log = Mojo::Log->new;

sub read_business {
    my $self = shift;
    
    $self->data( foo => 'bar' )->message('Not used');

}

sub list_business {
    my $self = shift;

    my $schema   = $self->schema();
    my ( $businesses, $count )   = $schema->resultset( 'Letter' )->get_businesses();
    $self->data( businesses => $businesses, count => $count )->message('Looks good');
}


1;
