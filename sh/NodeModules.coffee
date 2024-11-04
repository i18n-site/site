#!/usr/bin/env coffee

> ./conf > ROOT
  path > join
  @3-/read

export node_modules = join ROOT,'node_modules'

{
  devDependencies
  dependencies
} = JSON.parse read(
  join ROOT,'package.json'
)

export default NODE_MODULES = []

for pkg from [
  dependencies
  devDependencies
]
  NODE_MODULES.push ... Object.keys(pkg)

