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

    function itemAddToCart(id) {
        dispatch(ActionTypes.itemAddToCart, {
                     "payload": id
                 })
    }

    function itemRemoveFromCart(id) {
        dispatch(ActionTypes.itemRemoveFromCart, {
                     "payload": id
                 })
    }

    function checkoutCart() {
        dispatch(ActionTypes.checkoutCart)
    }
}
