import QtQuick 2.7
import QuickFlux 1.1
import actions 1.0

Middleware {
    function dispatch(type, message) {
        switch (type) {
        case ActionTypes.startApp:
            next(type, message)
            break
        case ActionTypes.quitApp:
            Qt.quit()
            break
        default:
            next(type, message)
            break
        }
    }
}
