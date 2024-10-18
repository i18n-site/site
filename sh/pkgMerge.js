#!/usr/bin/env bun

import merge from "lodash-es/merge"
import { join, dirname } from "node:path"
import write from "@3-/write"
import rJson from "@3-/read/rJson.js"

const wJson = (fp, data) => {
	write(fp, JSON.stringify(data, null, 2))
}

const main = () => {
	const ROOT = dirname(import.meta.dirname)
	const PACKAGE_JSON = "package.json"

	const DPKG_FP = join(ROOT, "." + PACKAGE_JSON)
	const DPKG = rJson(DPKG_FP)

	const PKG_FP = join(ROOT, PACKAGE_JSON)
	const PKG = rJson(PKG_FP)

	const CPKG_FP = join(ROOT, "conf", PACKAGE_JSON)
	const CPKG = rJson(CPKG_FP)

	for (const i of ["dependencies", "devDependencies", "peerDependencies"]) {
		const dep = PKG[i] || {}

		let cdep = CPKG[i]
		if (!cdep) {
			CPKG[i] = cdep = {}
		}

		let ddep = DPKG[i]
		if (!ddep) {
			DPKG[i] = ddep = {}
		}

		for (const [name, ver] of Object.entries(dep)) {
			if (cdep[name]) {
				cdep[name] = ver
			} else {
				ddep[name] = ver
			}
		}
	}
	wJson(DPKG_FP, DPKG)
	wJson(CPKG_FP, CPKG)
}

export default main

if (process.argv[1] == decodeURI(new URL(import.meta.url).pathname)) {
	main()
}
