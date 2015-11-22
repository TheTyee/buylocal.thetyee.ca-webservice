# buylocal.thetyee.ca - Web service

> Web service that consumes incoming webhooks from Wufoo, and exposes standard REST endpoints to the contest data

...

MOJO_MODE=develop MOJO_LOG_LEVEL=debug carton exec hypnotoad script/buy_local
MOJO_MODE=preview MOJO_LOG_LEVEL=debug carton exec hypnotoad script/buy_local
MOJO_MODE=production carton exec hypnotoad script/buy_local
