import QtQuick 2.15

QtObject {
    property var items: []

    function incrementItem(id) {
        const maybeItem = items.find(item => item.id === id)
        if (!!maybeItem) {
            maybeItem.qtty++
            itemsChanged()
        }
    }

    function decrementItem(id) {
        const maybeItem = items.find(item => item.id === id)
        const notZeroQtty = !!maybeItem && maybeItem.qtty !== 0
        if (notZeroQtty) {
            maybeItem.qtty--
            itemsChanged()
            return false
        }
        return !notZeroQtty
    }
}
