import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15
import QSyncable 1.0
import actions 1.0
import constants 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0
import "../../js/Utils.js" as Utils

Pane {
    property int cartCost: 10
    signal checkoutPressed
    Material.background: Material.DeepOrange
    Material.foreground: "white"
    background: Rectangle {
        color: Material.backgroundColor
        clip: true
        radius: 43
    }
    RowLayout {
        anchors.centerIn: parent
        Button {
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("Checkout")
            onClicked: checkoutPressed()
            background: Rectangle {
                color: Material.accentColor
                clip: true
                radius: 10
            }
        }
        Label {
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("Total Cost:") + Number(
                      cartCost / 100).toLocaleCurrencyString(Qt.locale())
        }
    }
}
