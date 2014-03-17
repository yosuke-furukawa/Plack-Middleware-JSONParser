package Plack::Middleware::JSONParser;
use 5.008005;
use strict;
use warnings;
use JSON;
use Hash::MultiValue;
use Data::Dumper;
use Plack::Request;

our $VERSION = "0.01";

use parent 'Plack::Middleware';

sub call {
    my ($self, $env) = @_;

    my $content_type = $env->{'CONTENT_TYPE'};
    if ($content_type && $content_type =~
        m{\Aapplication/json(;\s*charset=(utf|UTF)-?8)?\z}o) {
        my $req = Plack::Request->new( $env );
        my $json = decode_json($req->raw_body());
        $env->{'plack.request.body'} = Hash::MultiValue->from_mixed(
            $json
        );
    }

    return $self->app->($env);
}

1;
__END__

=encoding utf-8

=head1 NAME

Plack::Middleware::JSONParser - It's new $module

=head1 SYNOPSIS

    use Plack::Middleware::JSONParser;

=head1 DESCRIPTION

Plack::Middleware::JSONParser is ...

=head1 LICENSE

Copyright (C) Yosuke Furukawa.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Yosuke Furukawa E<lt>furukawa.yosuke@dena.jpE<gt>

=cut

