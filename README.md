# NAME

Plack::Middleware::JSONParser - It's new $module

# SYNOPSIS

    use Plack::Middleware::JSONParser;

# DESCRIPTION

JSONParser parses json to hash multivalue object. it substitute the multivalue object for "plack.request.body" when content-type is 'application/json' and request body has JSON.

Most client side MVC frameworks use RESTFul requests.
However Plack cannot handle the JSON in content body as Perl object.

# LICENSE

Copyright (C) Yosuke Furukawa.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Yosuke Furukawa
