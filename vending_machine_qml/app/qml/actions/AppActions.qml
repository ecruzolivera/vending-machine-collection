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
    function itemSelected(id) {
        dispatch(ActionTypes.itemSelected, {
                     "payload": id
                 })
    }
    function buySelected(id) {
        dispatch(ActionTypes.buySelected, {
                     "payload": id
                 })
    }

    function push(item, properties, operation) {
        stackViewId.push(item, properties, operation)
    }

    function pop(item, operation) {
        stackViewId.pop(item, operation)
    }

    function replace(target, item, properties, operation) {
        stackViewId.replace(target, item, properties, operation)
    }
}
