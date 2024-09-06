> x/a.js:
  ~/styl/site.styl
  ~/lib/USE.js:
  ~/lib/NAV.js:
  ~/Index.svelte
  @2-/doc/BODY.js
  @8p/smnt:Mount

# > @3-/idb
#
# TABLE_URI_VER_BIN = 1
# EXT = 'e'
# PATH = 'p'
#
# await idb.vf(
#   1 # version
#   {
#     upgrade: (db)=>
#       db.createObjectStore TABLE_URI_VER_BIN, {
#         keyPath: [EXT, PATH]
#       }
#       return
#   }
# )


Mount(
  Index
  BODY
)

BODY.style = ''

log = =>
  if (outerWidth > innerWidth) or (outerHeight - innerHeight > 130)
    console.log('%cPower By https://I18N.SITE','font-size:16px;font-weight:bold;color:#f40;padding:9px 0')
  return
addEventListener('resize',log)
log()
