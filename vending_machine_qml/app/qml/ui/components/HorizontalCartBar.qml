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

Rectangle {
    color: Material.primaryColor
    radius: 43
    RowLayout {
        anchors.fill: parent
        Image {
            source: Assets.shoppingCartIcon
        }
        Label {
            text: qsTr("Your Cart")
        }
        Label {
            text: qsTr("Total Cost:") + Number(
                      priv.cartCurrentCost / 100).toLocaleCurrencyString(
                      Qt.locale())
        }
        Button {
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("Checkout")
            onClicked: AppActions.checkoutCart()
        }
    }
}
