import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
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
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: parent.right
        }

        Row {
            Layout.alignment: Qt.AlignVCenter
            spacing: 12
            Image {
                source: Assets.shoppingCartIcon
            }
            Label {
                text: qsTr("Your Cart")
            }
        }
        Row {
            Layout.alignment: Qt.AlignVCenter
            spacing: 12
            Label {
                text: qsTr("Total Cost:") + Number(
                          cartCost / 100).toLocaleCurrencyString(Qt.locale())
            }
            Button {
                text: qsTr("Checkout")
                onClicked: checkoutPressed()
            }
        }
    }
}
