use utf8;
package BuyLocal::Schema::Result::Letter;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BuyLocal::Schema::Result::Letter

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<letters>

=cut

__PACKAGE__->table("letters");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'buylocal.letters_id_seq'

=head2 entry_id

  data_type: 'integer'
  is_nullable: 0

=head2 timestamp

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}
  timezone: 'America/Vancouver'

=head2 date_created

  data_type: 'timestamp with time zone'
  is_nullable: 0
  timezone: 'America/Vancouver'

=head2 first_name

  data_type: 'text'
  is_nullable: 0

=head2 last_name

  data_type: 'text'
  is_nullable: 0

=head2 email

  data_type: 'text'
  is_nullable: 0

=head2 business_name

  data_type: 'text'
  is_nullable: 0

=head2 business_city

  data_type: 'text'
  is_nullable: 0

=head2 business_url

  data_type: 'text'
  is_nullable: 1

=head2 letter_text

  data_type: 'text'
  is_nullable: 0

=head2 public_name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "buylocal.letters_id_seq",
  },
  "entry_id",
  { data_type => "integer", is_nullable => 0 },
  "timestamp",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
    timezone      => "America/Vancouver",
  },
  "date_created",
  {
    data_type   => "timestamp with time zone",
    is_nullable => 0,
    timezone    => "America/Vancouver",
  },
  "first_name",
  { data_type => "text", is_nullable => 0 },
  "last_name",
  { data_type => "text", is_nullable => 0 },
  "email",
  { data_type => "text", is_nullable => 0 },
  "business_name",
  { data_type => "text", is_nullable => 0 },
  "business_city",
  { data_type => "text", is_nullable => 0 },
  "business_url",
  { data_type => "text", is_nullable => 1 },
  "letter_text",
  { data_type => "text", is_nullable => 0 },
  "public_name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-11 22:33:33
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lyPVScHIFqef84A6CBxLFg

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->table("buylocal.letters");
1;
