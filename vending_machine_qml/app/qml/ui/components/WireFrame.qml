import QtQuick 2.15


/**
    \qmltype WireFrame
    \inherits Loader
    \qmlproperty var target
    optional paramenter for the item to attach, if not used will attach to the parent
    \brief Displays a randomly colorized rectangular frame in the border of an visual object, for example:
    \qml
        TextEdit {
           ...
           WireFrame {} // will attach to the parent
        }
        ...

        Column {
            id: col
        }

        WireFrame {
            target: col
        }
    \endqml
*/
Loader {
    id: root
    property var target
    anchors {
        top: root.target ? root.target.top : undefined
        bottom: root.target ? root.target.bottom : undefined
        left: root.target ? root.target.left : undefined
        right: root.target ? root.target.right : undefined
        fill: root.target ? undefined : parent
    }
    asynchronous: true
    active: true
    sourceComponent: Rectangle {
        color: "transparent"
        border {
            color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
            width: 2
        }
    }
}
