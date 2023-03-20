import QtQuick 2.15

Loader {
    property var target
    anchors {
        top: target ? target.top : undefined
        bottom: target ? target.bottom : undefined
        left: target ? target.left : undefined
        right: target ? target.right : undefined
        fill: target ? undefined : parent
    }
    asynchronous: true
    active: true
    sourceComponent: Rectangle {
        color: "transparent"
        border.color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
    }
}
