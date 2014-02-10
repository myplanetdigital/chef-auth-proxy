# auth-proxy cookbook

This cookbook sets up and configures [auth-proxy](https://github.com/tizzo/auth-proxy).

# Requirements

For cookbook requirements, see [metadata.rb](metadata.rb). See
[Berksfile](Berksfile) for non-standard cookbook details (ie. those not
from community site).

Tested on Ubuntu Precise 12.04 LTS.

# Usage

Override any of the [default config
settings](https://github.com/tizzo/auth-proxy) via the
`node_proxy['config']` hash.

A `proxy_routes` databag is required with an entry for each route, using
the keys explained in [proxy-auth's
docs](https://github.com/tizzo/auth-proxy#defining-routes)

# Attributes

Please see [attributes/default.rb](attributes/default.rb).

# Recipes

* `default.rb` - Sets up auth-proxy service, daemonizing via Upstart.

# Author

Author:: Patrick Connolly (<patrick@myplanetdigital.com>)
