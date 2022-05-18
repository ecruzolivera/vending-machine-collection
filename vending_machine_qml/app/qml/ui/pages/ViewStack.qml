import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QuickFlux 1.1
import QSyncable 1.0

import ui.pages 1.0
import stores 1.0

Item {
    StackView {
        id: stackViewId
        anchors.fill: parent
        initialItem: Pages.home
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 400
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 400
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 400
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 400
            }
        }
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
