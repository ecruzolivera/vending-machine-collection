import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import constants 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Item {
    id: root
    property var model: []
    property int cartCost: 0
    signal backButtonClicked
    signal payButtonClicked
    ColumnLayout {
        spacing: 20
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.bold: true
            text: qsTr("Summary")
        }
        ListView {
            id: checkoutListId
            Layout.preferredHeight: priv.maxItemsInSummary * 100
            Layout.preferredWidth: priv.itemWidth
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            clip: true
            interactive: count > priv.maxItemsInSummary
            model: root.model
            delegate: ItemCardInBottomBar {
                itemId: modelData.id
                itemName: modelData.name
                imageUrl: modelData.image
                totalPrice: modelData.totalPrice
                qttyInCart: modelData.qtty
            }
        }
        Row {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            spacing: 10
            Label {
                font.bold: true
                text: qsTr("Total:")
            }
            Label {
                text: `${Number(cartCost / 100).toLocaleCurrencyString(
                          Qt.locale())}`
            }
        }
        Row {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            spacing: 20
            Button {
                text: qsTr("Back")
                onClicked: root.backButtonClicked()
            }
            Button {
                text: qsTr("Pay")
                onClicked: root.payButtonClicked()
            }
        }
        QtObject {
            id: priv
            property int itemWidth: 400
            readonly property int maxItemsInSummary: 5
        }
    }
}
