#!/usr/bin/env coffee

> @3-/read
  @3-/write
  @3-/utf8/utf8e.js
  path > dirname join
  @3-/walk > walkRel
  fs > unlinkSync renameSync
  ./npmHash.coffee

import { createHash } from 'crypto'

HASH = 'sha3-512'
ROOT = dirname import.meta.dirname
CONF = join ROOT,'conf'
PUBLIC = join ROOT, 'public'
DIST = join ROOT, 'dist'
CSS = 'css'
CSS_JS = [CSS,'js']

_replace = (file, fp, ext_li)=>
  txt = read fp
  for ext from ext_li
    for [from_file,to_file] in Object.entries(file[ext])
      txt = txt.replaceAll(
        from_file
        to_file
      )
  return txt

replace = (file, hash_update)=>
  for ext from CSS_JS
    for name in Object.values file[ext]
      fp = join DIST,name
      txt = _replace(
        file
        fp
        if ext == CSS then [CSS] else CSS_JS
      )
      write fp, txt
      hash_update(utf8e txt)
  return

index = =>
  fp = join DIST,'index.html'
  htm = read fp
  unlinkSync fp
  + css,js
  for i from htm.split('//_')
    if i.startsWith('I/')
      file = i.split('"')[0].slice(2)
      if 'js' == file.slice(-2)
        js = file
      else
        css = file
  return [css, js]

rename = (file)=>
  gen_file = {css:{},js:{}}

  _rename = (f,t,ext)=>
    dext = '.'+ext
    t+=dext
    console.log(f,'→',t)
    gen_file[ext][f]=t
    renameSync(
      join DIST,f
      join DIST,t
    )
    return

  css_js = index()

  + css, js

  CSS_JS.forEach(
    (ext,p)=>
      name = css_js[p]
      _rename(name, '-', ext)
      li = file[ext]
      li.splice(li.indexOf(name),1)
      return
  )

  for [ext,li] from Object.entries(file)
    li.sort()
    for name,pos in li
      to = pos.toString(36)
      _rename(
        name
        to
        ext
      )

  return gen_file

ls = =>
  file = {}
  for i from CSS_JS
    file[i] = []

  for await i from walkRel DIST
    ext = i.split('.').pop()
    if CSS_JS.includes(ext)
      li = file[ext]
      li.push(i)
  return file

< default main = =>
  for await i from walkRel PUBLIC
    unlinkSync join(DIST,i)

  file = await ls()

  ft = rename(file)

  [
    hash
    publish
  ] = npmHash()

  replace ft, hash

  await publish(
    ROOT,DIST,'site'
    (ver)=>
      write(
        join DIST, '.v'
        ver
      )

      for i in Object.values(ft.js)
        fp = join DIST, i
        txt = read fp
        site_ver = "site@#{ver}/"
        txt = txt.replaceAll(
          '"//_I/"'
          " _I+'#{site_ver}'"
        ).replaceAll(
          '}from"./'
          '}from"i/'+site_ver
        ).replaceAll(
          'import("./'
          'import("i/'+site_ver
        )
        write fp, txt
      return
  )
  return

if process.argv[1] == decodeURI (new URL(import.meta.url)).pathname
  await main()
  process.exit()

