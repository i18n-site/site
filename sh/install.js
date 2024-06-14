#!/usr/bin/env bun

import pkgMerge from "./pkgMerge.js"
import { $raw } from "@3-/zx"
import write from "@3-/write"
import read from "@3-/read"
import { existsSync, copyFileSync } from "node:fs"
import { join, dirname } from "node:path"
import { load } from "@3-/yml"

$.verbose = true

const ROOT = dirname(import.meta.dirname)
const PACKAGE_JSON = "package.json"
const DPKG_FP = join(ROOT, "." + PACKAGE_JSON)
const PKG_FP = join(ROOT, PACKAGE_JSON)
const CONF = join(ROOT, "conf")
const PLUGIN = load(join(CONF, "plugin.yml"))
const PLUGIN_LI = []
for (let i of PLUGIN.npm?.split("\n")) {
	i = i.trim()
	if (i && !i.startsWith("#")) {
		PLUGIN_LI.push(i)
	}
}

if (existsSync(PKG_FP)) {
	pkgMerge()
}

copyFileSync(DPKG_FP, PKG_FP)

cd(ROOT)
await $`bun i`

await $raw`bun i ${PLUGIN_LI.join(" ")}`

const PKG = JSON.parse(read(PKG_FP))

PKG.peerDependencies = PKG.peerDependencies || {}

PLUGIN_LI.forEach((i) => {
	i = i.charAt(0) + i.slice(1).split("@")[0]
	const ver = PKG.dependencies[i]
	delete PKG.dependencies[i]
	PKG.peerDependencies[i] = ver
})

write(PKG_FP, JSON.stringify(PKG))
