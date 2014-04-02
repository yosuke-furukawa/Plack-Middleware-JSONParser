use strict;
use warnings;
use Test::More;
use Plack::Test;
use Data::Dumper;
use Plack::Middleware::JSONParser;
use HTTP::Request::Common;

my $body;
my $app = sub {
    my $env = shift;
    [200, ['Content-Type' => 'text/plain'], [$body = $env->{'plack.request.body'}]];
};
$app = Plack::Middleware::JSONParser->wrap($app);

test_psgi $app, sub {
  my $cb = shift;
  my $req = HTTP::Request->new(POST => "/");
  $req->header('Content_Type' => 'application/json; charset=utf-8');
  $req->content('{ "name" : "yosuke", "age" : 31}');
  $cb->($req);
  is $body->{'name'}, "yosuke";
  is $body->{'age'}, 31;
};

done_testing;
