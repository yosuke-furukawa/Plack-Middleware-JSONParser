package Plack::Middleware::JSONParser;
use strict;
use warnings;
use JSON;
use Hash::MultiValue;
use Plack::Request;

our $VERSION = "0.01";

use parent 'Plack::Middleware';

sub call {
    my ($self, $env) = @_;

    my $content_type = $env->{'CONTENT_TYPE'};
    if ($content_type && $content_type =~
        m{\Aapplication/json}o) {
        my $req = Plack::Request->new( $env );
        my $raw_body = $req->raw_body();
        return $self->app->($env) unless ($raw_body);
        my $json = decode_json($raw_body);
        $env->{'plack.request.body'}->merge_mixed(
            $json
        );
    }
    $self->app->($env);
}

1;
__END__

=encoding utf-8

=head1 NAME

Plack::Middleware::JSONParser - It's new $module

=head1 SYNOPSIS

    use Plack::Middleware::JSONParser;

=head1 DESCRIPTION

JSONParser parses json to hash multivalue object. it substitute the multivalue object for "plack.request.body" when content-type is 'application/json' and request body has JSON.

=head1 LICENSE

Copyright (C) Yosuke Furukawa.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yosuke Furukawa E<lt>furukawa.yosuke@dena.jpE<gt>

=cut

