requires "Mojolicious", "0";
requires "Mojolicious::Plugin::JSONConfig", "0";
requires "Mojolicious::Plugin::REST", "";
requires "Mojolicious::Controller::REST", "";
requires "Mojolicious::Plugin::JSONP", "";
requires "Mojolicious::Plugin::SecureCORS", "";
requires "DateTime::Format::DateParse", "";
requires "Number::Format", "";
requires "DBIx::Class", "";
requires "DBIx::Class::TimeStamp", "";
requires "DateTime::Format::Pg", "";
# Need to load the schema w/ dbicdump
requires "DBIx::Class::Schema::Loader", "";
# Loader requires Config::General
requires "Config::General", "";
