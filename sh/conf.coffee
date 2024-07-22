#!/usr/bin/env coffee

> @3-/uridir
  path > dirname

export ROOT = dirname uridir(import.meta)
