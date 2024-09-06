> @3-/uridir
  path > dirname join

export PWD = uridir(import.meta)
export ROOT = dirname PWD
export PUBLIC = join ROOT,'public'
export SRC = join ROOT,'src'
export DIST = join ROOT, 'dist'
