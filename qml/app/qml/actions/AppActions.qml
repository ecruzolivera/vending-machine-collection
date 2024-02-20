pragma Singleton

import QtQuick 2.15
import QuickFlux 1.0

ActionCreator {
    signal startApp
    signal quitApp

    // navigation
    function navigatePush(item, properties, operation) {
        dispatch(ActionTypes.navigatePush, {
                     "payload": {
                         "item": item,
                         "properties": properties,
                         "operation": operation
                     }
                 })
    }

    function navigatePop(item, operation) {
        dispatch(ActionTypes.navigatePop, {
                     "payload": {
                         "item": item,
                         "operation": operation
                     }
                 })
    }

    function navigateReplace(target, item, properties, operation) {
        dispatch(ActionTypes.navigateReplace, {
                     "payload": {
                         "target": target,
                         "item": item,
                         "properties": properties,
                         "operation": operation
                     }
                 })
    }

    // Item selection
    function categorySelected(id) {
        dispatch(ActionTypes.categorySelected, {
                     "payload": id
                 })
    }

    function itemIncrement(id) {
        dispatch(ActionTypes.itemIncrement, {
                     "payload": id
                 })
    }

    function itemDecrement(id) {
        dispatch(ActionTypes.itemDecrement, {
                     "payload": id
                 })
    }

    function itemRemove(id) {
        dispatch(ActionTypes.itemRemove, {
                     "payload": id
                 })
    }

    function checkoutCart() {
        dispatch(ActionTypes.checkoutCart)
    }

    function payItems() {
        dispatch(ActionTypes.payItems)
    }

    function cancelPayment() {
        dispatch(ActionTypes.cancelPayment)
    }

    function moneyInserted(denomination) {
        dispatch(ActionTypes.moneyInserted, {
                     "payload": denomination
                 })
    }

    function returnMoney(amount) {
        dispatch(ActionTypes.returnMoney, {
                     "payload": amount
                 })
    }

    function moneyReturned() {
        dispatch(ActionTypes.moneyReturned)
    }

    function deliverItems() {
        dispatch(ActionTypes.deliverItems)
    }

    function itemsDelivered() {
        dispatch(ActionTypes.itemsDelivered)
    }
}
