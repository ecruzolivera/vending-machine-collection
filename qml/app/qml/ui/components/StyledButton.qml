import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: root
    property alias textColor: textId.color
    property alias backgroundColor: backgroundId.color
    property int backgroundBorderWidth: 0
    property color backgroundBorderColor: "transparent"
    property alias backgroundRadius: backgroundId.radius
    background: Rectangle {
        id: backgroundId
        border {
            width: root.backgroundBorderWidth
            color: root.backgroundBorderColor
        }

        opacity: root.pressed ? 0.3 : 1
    }
    contentItem: Text {
        id: textId
        text: root.text
        font: root.font
        opacity: root.enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
