import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15
import constants 1.0
import ui.theme 1.0

Loader {
    anchors.fill: parent
    asynchronous: true
    active: true
    sourceComponent: Rectangle {
        color: "transparent"
        border.color: Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
    }
}
