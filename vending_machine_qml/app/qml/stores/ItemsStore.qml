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
    property var insertedMoney: []
    property var insertedMoneyTotal: insertedMoney.reduce(
                                         (acc, current) => acc + current, 0)
    property string paymentState: ""

    property alias cart: cartId.cart
    property int cartItemsQtty: cart.reduce((prev, item) => prev + item.qtty, 0)
    property int cartCurrentCost: cart.reduce((prev, item) => {
                                                  try {
                                                      const currentItem = items.find(
                                                          i => i.id === item.id)
                                                      const currentItemPrice = currentItem.price
                                                      return prev + item.qtty * currentItemPrice
                                                  } catch (e) {
                                                      console.error(
                                                          JSON.stringify(e))
                                                      return 0
                                                  }
                                              }, 0)

    onCartChanged: console.log("cart:", JSON.stringify(cart))
    onInsertedMoneyChanged: console.log("inserted money:",
                                        JSON.stringify(insertedMoney))

    Filter {
        type: ActionTypes.categorySelected
        onDispatched: {
            console.log(type, JSON.stringify(message))
            const id = Utils.getSafe(() => message.payload, "")
            selectedCategoryId = id
        }
    }

    Filter {
        type: ActionTypes.itemAdd
        onDispatched: {
            console.log(type, JSON.stringify(message))
            const id = Utils.getSafe(() => message.payload)
            if (!!id) {
                cartId.addItem(id)
            } else {
                console.warn("Invalid Id")
            }
        }
    }

    Filter {
        type: ActionTypes.itemDecrement
        onDispatched: {
            console.log(type, JSON.stringify(message))
            const id = Utils.getSafe(() => message.payload, "")
            if (!!id) {
                cartId.decrementItem(id)
            } else {
                console.warn("Invalid Id")
            }
        }
    }

    Filter {
        type: ActionTypes.itemRemove
        onDispatched: {
            console.log(type, JSON.stringify(message))
            const id = Utils.getSafe(() => message.payload, "")
            if (!!id) {
                cartId.removeItem(id)
            } else {
                console.warn("Invalid Id")
            }
        }
    }

    Filter {
        type: ActionTypes.coinInserted
        onDispatched: {
            console.log(type, JSON.stringify(message))
            const denomination = Utils.getSafe(() => message.payload)
            if (!!denomination && typeof denomination === "number") {
                insertedMoney = [...insertedMoney, denomination]
                fsmId.sigMoneyInserted()
            } else {
                console.warn("Invalid denomination")
            }
        }
    }

    CartModel {
        id: cartId
    }

    VendingMachineFsm {
        id: fsmId
        onStateChanged: {
            console.log("entered state:", state)
            paymentState = state
            switch (state) {
            case Constants.stateIdle:
                insertedMoney = []
                break
            }
        }
    }
}
