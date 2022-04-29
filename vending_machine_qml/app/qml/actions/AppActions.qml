pragma Singleton

import QtQuick 2.0
import QuickFlux 1.0

ActionCreator {
    signal startApp
    signal quitApp

    function categorySelected(id) {
        dispatch(ActionTypes.categorySelected, {
                     "payload": id
                 })
    }
}
