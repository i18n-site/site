#!/usr/bin/env coffee
import { createHash } from 'crypto'

> @3-/read/rJson.js
  @3-/write
  @3-/read
  zx/globals:
  fs > existsSync
  path > join

PACKAGE_JSON = 'package.json'
HASH = 'sha3-512'

# pre_hash_fp = join(CONF, I18N+HASH_YML)

IS_DIST = '1' == process.env.DIST

< =>
  hash = createHash(HASH)
  [
    # update
    (bin)=>
      hash.update bin
      return

    # publish
    (
      root, outdir, project
      before = (
        # version
      )=>
    )=>
      if project
        project = project + '.'
      hash = hash.digest('base64url')
      conf_dir = join(root, 'conf')
      package_json_fp = join conf_dir, project+PACKAGE_JSON
      package_json = rJson package_json_fp
      pre_hash_fp = join(conf_dir, project+'hash.yml')
      { version, name } = package_json

      if IS_DIST and existsSync(pre_hash_fp)
        for i from read(pre_hash_fp).split('\n')
          i = i.trim()
          if i and not i.startsWith('#')
            i = i.split(':')
            if i.length == 2
              if hash == i[1].trim()
                console.log "✅ #{name} #{version} (#{outdir}) NO CHANGE"
                return

      version = version.split('.')
      ++version[2]
      package_json.version = version = version.join('.')

      await before(version)
      write(
        package_json_fp
        JSON.stringify(package_json, null, 2)
      )
      write(
        join outdir, PACKAGE_JSON
        JSON.stringify(package_json)
      )
      write(
        join outdir, 'README.md'
        "# #{name}\n\n#{package_json.description}\n\nsee [#{package_json.homepage}](#{package_json.homepage}) for more"
      )
      if IS_DIST
        cd outdir
        await $"npm publish --access=public"
        write(
          pre_hash_fp
          version+': '+ hash
        )
        return package_json
      else
        return
    ]
