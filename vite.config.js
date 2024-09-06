import viteConf from "@3-/vite-conf"
import vbD from "@3-/vb/vbD.js"
import { extract } from "@3-/extract"
import read from "@3-/read"
import rJson from "@3-/read/rJson.js"
import write from "@3-/write"
import { readFileSync } from "node:fs"
import utf8d from "@3-/utf8/utf8d.js"
import bintxt from "@3-/bintxt"
import { copyFileSync } from "node:fs"
import { join, dirname } from "node:path"
import merge from "lodash-es/merge"
import Yml from "@3-/yml/Yml.js"

const ROOT = import.meta.dirname

const conf = await viteConf(ROOT)

const env = process.env

const IS_DEV = env.NODE_ENV != "production"

merge(conf, {
	define: {
		I18N_VER: JSON.stringify(
			"@" +
				(IS_DEV
					? "latest"
					: rJson(join(ROOT, "conf/i18n.package.json")).version) +
				"/",
		),
	},
})

const MD = join(dirname(ROOT), "md")
const MD_HTM_CONF = env.MD_HTM_CONF || "dev"
const MD_HTM = Yml(join(MD, ".i18n/htm"))[MD_HTM_CONF]
const MD_V = join(MD, "out", MD_HTM_CONF, "v")

if (IS_DEV) {
	merge(conf, {
		plugins: [
			{
				name: "initHtm",
				enforce: "pre",
				transformIndexHtml: (htm) => {
					const head = "<head>"
					const [B, P] = read(join(MD_V, ".v"))
						.split(">")
						.map((ver, pos) => read(join(MD_V, ver, "BP"[pos] + ".js")))
					const html = read(join(MD, "public/index.html"))
					const style = extract(html, "<style>", "</style>")
					return htm.replace(
						head,
						`${head}<style>${style}</style><script>const _V='${MD_HTM.v}',_P=${P};(${B})('//127.0.0.1:7775/x/')()</script>`,
					)
				},
			},
		],
	})
}

const ignoreImport = (conf, external) => {
	// external = external.map((i) => (i.endsWith("@") ? i + "latest/" : i))
	// console.log({ external })
	const prefix = "//.+"
	const alias = {}
	external.push("x/")
	external.forEach((i) => {
		alias[i] = prefix + i
	})
	merge(conf, {
		resolve: { alias },
		build: {
			rollupOptions: { external },
		},
		optimizeDeps: {
			exclude: external,
		},
		plugins: [
			{
				name: "ignoreImport",
				enforce: "pre",
				// 2. push a plugin to rewrite the 'vite:import-analysis' prefix
				configResolved(resolvedConfig) {
					resolvedConfig.plugins.push({
						name: "replacePrefix",
						transform: (code) => {
							for (const [k, v] of Object.entries(alias)) {
								code = code.replaceAll(v, k)
							}
							// for (let i of code.split("\n")) {
							// 	if (i.includes("x/")) {
							// 		console.log(i)
							// 	}
							// }
							return code
						},
					})
				},
				// 3. rewrite the id before 'vite:resolve' plugin transform to 'node_modules/...'
				resolveId: (id) => {
					if (id.startsWith(prefix)) {
						if (!IS_DEV) {
							id = id.slice(prefix.length)
						}
						return { id, external: true }
					}
				},
			},
		],
	})
}

ignoreImport(conf, Object.keys(MD_HTM.importmap))

for (let [k, v] of Object.entries(conf.define)) {
	console.log(k, v)
}

export default conf
