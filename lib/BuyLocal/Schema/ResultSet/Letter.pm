use utf8;

package BuyLocal::Schema::ResultSet::Letter;

use strict;
use warnings;
use DateTime;
use parent 'DBIx::Class::ResultSet';

sub get_letter {
    my ( $self, $id ) = @_;
    my $schema = $self->result_source->schema;
    my $letter = $self->search( { id => $id },
        { result_class => 'DBIx::Class::ResultClass::HashRefInflator' } )->single;
    # TODO pass result through clean_letter()
    return $letter;
}

sub get_letters {
    my ( $self, $page, $limit ) = @_;
    my $schema = $self->result_source->schema;
    my $dtf = $schema->storage->datetime_parser;
    my $now = DateTime->now( time_zone => 'America/Vancouver' );
    my @letters = $self->search(
        {   
            date_created => { '<=' => $dtf->format_datetime($now) }, # Don't return items from the future! :)
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
    # TODO move to utility subroutine for cleaning:
    # - E-mails
    # - Numbers
    # - Bad words
    my @letters_clean;
    foreach my $letter (@letters) {
        # Only those who want their name publicly displayed
        if ( $letter->{'public_name'} =~ /yes/i ) {
            $letter->{'last_name'} = uc substr($letter->{'last_name'}, 0, 1);
        } else {
            $letter->{'first_name'} = 'Anonymous';
            $letter->{'last_name'}  = 'Fan';
        }
        delete $letter->{'public_name'};
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

1;
