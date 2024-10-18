#!/usr/bin/env bun

import merge from "lodash-es/merge"
import rJson from "@3-/read/rJson.js"
import pkgMerge from "./pkgMerge.js"
import { $raw } from "@3-/zx"
import write from "@3-/write"
import read from "@3-/read"
import { existsSync, copyFileSync } from "node:fs"
import { join, dirname } from "node:path"
import { load } from "@3-/yml"

$.verbose = true

const PACKAGE_JSON = "package.json"
const ROOT = dirname(import.meta.dirname)
const DPKG_FP = join(ROOT, "." + PACKAGE_JSON)
const PKG_FP = join(ROOT, PACKAGE_JSON)
const CONF = join(ROOT, "conf")
const CPKG_FP = join(ROOT, "conf", PACKAGE_JSON)
const CPKG = rJson(CPKG_FP)
const DPKG = rJson(DPKG_FP)

if (existsSync(PKG_FP)) {
	pkgMerge()
}

write(PKG_FP, JSON.stringify(merge(CPKG, DPKG), null, 2))

cd(ROOT)
await $`bun i`
