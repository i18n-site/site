#!/usr/bin/env bun

import merge from "lodash-es/merge"
import read from "@3-/read"
import { join, dirname } from "node:path"
import write from "@3-/write"

const main = () => {
	const ROOT = dirname(import.meta.dirname)
	const PACKAGE_JSON = "package.json"
	const DPKG_FP = join(ROOT, "." + PACKAGE_JSON)
	const PKG_FP = join(ROOT, PACKAGE_JSON)
	const DPKG = JSON.parse(read(DPKG_FP))
	const PKG = JSON.parse(read(PKG_FP))
	delete PKG.peerDependencies
	write(DPKG_FP, JSON.stringify(merge(DPKG, PKG), null, 2))
}

export default main

if (process.argv[1] == decodeURI(new URL(import.meta.url).pathname)) {
	main()
}
