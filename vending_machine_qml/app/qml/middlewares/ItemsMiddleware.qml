import QtQuick 2.7
import QuickFlux 1.1
import vendor.QuickPromise 1.0
import actions 1.0
import stores 1.0
import ui.pages 1.0

Middleware {
    function dispatch(type, message) {
        switch (type) {
        case ActionTypes.quitApp:
            Qt.quit()
            break
        case ActionTypes.startApp:
            next(type, message)
            break
        case ActionTypes.checkoutCart:
            next(type, message)
            AppActions.navigatePush(Pages.checkout)
            break
        case ActionTypes.deliverItems:
            next(type, message)
            Q.setTimeout(() => AppActions.itemsDelivered(), 3000)
            break
        case ActionTypes.returnMoney:
            next(type, message)
            Q.setTimeout(() => AppActions.moneyReturned(), 3000)
            break
        default:
            next(type, message)
            break
        }
    }
}
