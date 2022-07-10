import QtQuick 2.15
import QuickFlux 1.1
import actions 1.0
import "../js/Utils.js" as Utils

Middleware {
    required property var stackView

    function dispatch(type, message) {
        switch (type) {
        case ActionTypes.navigatePush:
            next(type, message)
            onNavigatePush(message)
            break
        case ActionTypes.navigatePop:
            next(type, message)
            onNavigatePop(message)
            break
        case ActionTypes.navigateReplace:
            next(type, message)
            onNavigateReplace(message)
            break
        default:
            next(type, message)
            break
        }
    }

    function onNavigatePush(message) {
        const item = Utils.getSafe(() => message.payload.item)
        const properties = Utils.getSafe(() => message.payload.properties)
        const operation = Utils.getSafe(() => message.payload.operation)
        stackView.push(item, properties, operation)
    }

    function onNavigatePop(message) {
        const item = Utils.getSafe(() => message.payload.item)
        const operation = Utils.getSafe(() => message.payload.operation)
        stackView.pop(item, operation)
    }

    function onNavigateReplace(message) {
        const target = Utils.getSafe(() => message.payload.target)
        const item = Utils.getSafe(() => message.payload.item)
        const properties = Utils.getSafe(() => message.payload.properties)
        const operation = Utils.getSafe(() => message.payload.operation)
        stackView.replace(target, item, properties, operation)
    }
}
