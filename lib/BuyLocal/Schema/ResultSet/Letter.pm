use utf8;

package BuyLocal::Schema::ResultSet::Letter;

use strict;
use warnings;
use DateTime;
use parent 'DBIx::Class::ResultSet';
use Data::Dumper;

sub get_letter {
    my ( $self, $id ) = @_;
    my $schema = $self->result_source->schema;
    my $letter = $self->search( { id => $id },
        { result_class => 'DBIx::Class::ResultClass::HashRefInflator' } )->single;
    $letter = _clean_letter( $letter );
    return $letter;
}

sub get_letters {
    my ( $self, $page, $limit, $query ) = @_;
    my $schema = $self->result_source->schema;
    my $dtf = $schema->storage->datetime_parser;
    my $now = DateTime->now( time_zone => 'America/Vancouver' );
    my @letters = $self->search(
        {   
            date_created => { '<=' => $dtf->format_datetime($now) }, # Don't return items from the future! :)
            (   defined $query
                ? ( 'business_name' => { 'like', "%$query%" } )
                : ()
            ),
        },
        {   
            columns => [qw/id first_name last_name business_name business_url business_city date_created public_name letter_text/],
            page => $page || 1,     # page to return (default: 1)
            rows => $limit || 20,    # number of results per page (default: 20)
            order_by =>  { -desc => 'date_created' },
            # Recommended way to send simple data to a template vs. sending the ResultSet object
            result_class => 'DBIx::Class::ResultClass::HashRefInflator'
        }
    );
    my @letters_clean;
    foreach my $letter (@letters) {
        $letter = _clean_letter( $letter );
        push @letters_clean, $letter; 
    }

    return \@letters_clean;
}

sub get_businesses {
    my ( $self, $page, $limit ) = @_;
    my $schema = $self->result_source->schema;
    my $dtf = $schema->storage->datetime_parser;
    my $now = DateTime->now( time_zone => 'America/Vancouver' );
    my $count = $self->search({}, {
        columns => [ qw/business_name/ ],
        distinct => 1
    });
    my @businesses = $self->search(
        {   
        },
        {   
            columns => [qw/business_name business_city/],
            distinct => 1,
            order_by => [qw/ business_name /],
            # Recommended way to send simple data to a template vs. sending the ResultSet object
            result_class => 'DBIx::Class::ResultClass::HashRefInflator'
        }
    );
    return \@businesses, $count;
}

sub _clean_letter {
    my $letter = shift;
    print Dumper( $letter );
    if ( $letter->{'public_name'} =~ /yes/i ) {
        $letter->{'last_name'} = uc substr($letter->{'last_name'}, 0, 1);
    } else {
        $letter->{'first_name'} = 'Anonymous';
        $letter->{'last_name'}  = 'Fan';
    }
    delete $letter->{'public_name'};
    return $letter;
}


1;
