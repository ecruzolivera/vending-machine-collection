import QtQuick 2.15

QtObject {
    property var cart: []

    function addItem(id) {
        const itemInCart = cart.some(item => item.id === id)
        if (itemInCart) {
            cart = cart.map(item => {
                                if (item.id === id) {
                                    item.qtty += 1
                                    return item
                                }
                                return item
                            })
        } else {
            cart = [...cart, {
                        "id": id,
                        "qtty": 1
                    }]
        }
    }

    function decrementItem(id) {
        const item = cart.find(item => item.id === id)
        if (!!item) {
            item.qtty -= 1
            if (item.qtty === 0) {
                removeItem(id)
            } else {
                cart = cart
            }
        }
    }

    function removeItem(id) {
        const index = cart.findIndex(item => item.id === id)
        if (index !== -1) {
            const cartCopy = [...cart]
            cartCopy.splice(index, 1)
            cart = [...cartCopy]
        }
    }
}
