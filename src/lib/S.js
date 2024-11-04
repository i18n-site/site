import { captcha } from "@8p/captcha"
import lang from "@8p/lang"
import fBin from "x/fBinPrefix.js"
import AUTH from "@2-/conf/AUTH.js"
const fbin = fBin(_API)

export const req = async (url, opt) => {
	opt.method = opt.method || "POST"
	opt.headers = opt.headers || {}
	opt.headers["Accept-Language"] = lang()
	opt.credentials = "include"
	try {
		return await fbin(url, opt)
	} catch (r) {
		const { status } = r
		if (status) {
			switch (status) {
				case 417: // form error
					try {
						r = await r.json()
					} catch (err) {
						r = err
						break
					}
					throw r
				case 401:
					return new Promise((resolve, reject) => {
						AUTH(() => req(url, opt).then(resolve, reject))
					})
				case 412: // captcha error
					return captcha(url, opt.body, new Uint8Array(await r.arrayBuffer()))
			}
		}
		throw r
	}
}

export default new Proxy(
	{},
	{
		get:
			(_, url) =>
			async (...args) => {
				const opt = {},
					{ length } = args
				if (length) {
					opt.body = JSON.stringify(length > 1 ? args : args[0])
				}
				return req(url, opt)
			},
	},
)
