#!/usr/bin/env coffee

> ./env > ROOT SRC
  @3-/read
  @3-/write
  @3-/walk > walkRel
  path > join
  svgo > loadConfig optimize

conf = await loadConfig(
  join ROOT, 'sh/svgo.config.cjs'
)

VAR = join(
  ROOT
  'file/var'
)

out = [
  ":root{"
]

for await fp from walkRel VAR
  if not fp.endsWith('.svg')
    continue
  console.log fp
  svg = read join VAR, fp
  svg = optimize(
    svg.trim()
  ).data.replaceAll('#','%23')
  name = fp.charAt(0).toUpperCase() + fp.slice(1,-4)
  out.push """--svg#{name}:url('data:image/svg+xml;utf8,#{svg}');"""
out.push '}'
write(
  join SRC, 'styl/svg.css'
  out.join('\n')
)
