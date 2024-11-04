#!/usr/bin/env coffee
> os > homedir
  path > join
  @3-/yml/Yml.js

CONF = join homedir(),'.config'

YML = Yml(CONF)['i18n.site']

export default YML.token
