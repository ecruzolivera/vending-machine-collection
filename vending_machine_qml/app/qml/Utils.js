.pragma library

function getSafe(prop, defaultValue) {
    defaultValue = defaultValue || null
    try {
        const retval = prop
        return retval !== undefined ? retval : defaultValue
    } catch (e) {
        return defaultValue
    }
}
