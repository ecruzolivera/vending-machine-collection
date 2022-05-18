.pragma library

function getSafe(fn, defaultVal) {
    try {
        return fn()
    } catch (e) {
        if (typeof defaultVal === "undefined") {
            defaultVal = null
        }
        return defaultVal
    }
}
