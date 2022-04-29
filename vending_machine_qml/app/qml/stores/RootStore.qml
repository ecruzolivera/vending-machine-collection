import QtQuick 2.15
import QuickFlux 1.1
import actions 1.0

Store {
    readonly property string appName: qsTr("Vending Machine")
    property bool isStarted: false

    Filter {
        type: ActionTypes.startApp
        onDispatched: {
            console.log("ActionTypes.startApp")
            isStarted = true
        }
    }

    property alias items: itemsId
    ItemsStore {
        id: itemsId
    }
}
