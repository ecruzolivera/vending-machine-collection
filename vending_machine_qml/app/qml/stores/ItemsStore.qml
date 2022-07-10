import QtQuick 2.15
import Qt.labs.settings 1.1
import QuickFlux 1.1
import UUId 1.0
import actions 1.0
import constants 1.0
import "../js/Utils.js" as Utils
import "db.js" as Db

Store {
    id: root
    property var db: Db.db()
    property var categories: Utils.getSafe(() => db.categories, [])
    property var items: Utils.getSafe(() => db.items, [])
    property string selectedCategoryId: ""
    property var selectedCategoryItems: items.filter(
                                            item => item.categoryId === selectedCategoryId)
                                        || []
    property string selectedItemId: ""
    property var selectedItem: items.find(item => item.id === selectedItemId)

    property var cart: []

    onCartChanged: console.log(JSON.stringify(cart))

    Filter {
        type: ActionTypes.categorySelected
        onDispatched: {
            console.log(type, JSON.stringify(message))
            const id = Utils.getSafe(() => message.payload, "")
            selectedCategoryId = id
        }
    }

    Filter {
        type: ActionTypes.itemAddToCart
        onDispatched: {
            console.log(type, JSON.stringify(message))
            const id = Utils.getSafe(() => message.payload, "")
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
    }

    Filter {
        type: ActionTypes.itemRemoveFromCart
        onDispatched: {
            console.log(type, JSON.stringify(message))
            const id = Utils.getSafe(() => message.payload, "")
            const index = cart.findIndex(item => item.id === id)
            if (index !== -1) {
                const cartCopy = [...cart]
                cartCopy.splice(index, 1)
                cart = [...cartCopy]
            }
        }
    }

    QtObject {
        id: priv
    }
}
