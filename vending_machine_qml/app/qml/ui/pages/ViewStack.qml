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
        replaceEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 400
            }
        }
        replaceExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 400
            }
        }
    }

    function push(item, properties, operation) {
        console.log("viewstack push:", item)
        stackViewId.push(item, properties, operation)
    }

    function pop(item, operation) {
        if (!!item) {
            console.log("viewstack pop:", item)
        }
        const poped = stackViewId.pop(item, operation)
        console.log("viewstack pop:", poped)
    }

    function replace(target, item, properties, operation) {
        console.log("viewstack replace target:", target, "item:", item)
        stackViewId.replace(target, item, properties, operation)
    }
}
