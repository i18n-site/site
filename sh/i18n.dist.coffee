#!/usr/bin/env coffee

> ./npmHash.coffee

import { readdirSync, readFileSync } from 'fs'
import { join, dirname } from 'path'

ROOT = dirname import.meta.dirname
CONF = join ROOT, 'conf'
GEN = join ROOT, '.gen'
I18N = 'i18n'
DJS = '.js'
I18N_DIR = join GEN, I18N

i18nHash = (hash_update)=>

  li = []
  for i from readdirSync(I18N_DIR)
    if i.endsWith(DJS) and i != 'I'+DJS
      li.push i
  li.sort()

  for i from li
    hash_update readFileSync join(I18N_DIR, i)

  return

< default main = =>
  [
    hash
    publish
  ] = npmHash()

  i18nHash(hash)

  await publish(ROOT, I18N_DIR, I18N)

  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

