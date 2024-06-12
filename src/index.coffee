> x/a.js:
  ~/lib/USE.js:
  ~/lib/NAV.js:
  ~/plugin.js:
  ~/Index.svelte
  ~/styl/site.styl
  @2-/doc/BODY.js
  @8p/smnt:Mount
  @2-/has_mouse:HAS_MOUSE

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

# 判断是否鼠标 https://stackoverflow.com/questions/7838680/detecting-that-the-browser-has-no-mouse-and-is-touch-only
Mount(
  Index
  BODY
)

if HAS_MOUSE
  # 必须 setTimeout, 不然虽然开发版没问题, 但是发布版会没法导入
  setTimeout(
    =>
      (await import("@8p/mouse")).default()
      return
  )

