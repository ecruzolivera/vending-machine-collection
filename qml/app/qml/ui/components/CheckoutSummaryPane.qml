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
            font {
                bold: true
                pointSize: 40
            }
            text: qsTr("Summary")
        }
        ListView {
            id: checkoutListId
            Layout.preferredHeight: priv.maxItemsInSummary * 100
            Layout.preferredWidth: priv.cardWidth
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            clip: true
            interactive: count > priv.maxItemsInSummary
            model: JsonListModel {
                keyField: "id"
                source: root.model
            }
            delegate: itemDelegateId
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
            UserButton {
                width: 80
                text: qsTr("Back")
                textColor: "white"
                onClicked: root.backButtonClicked()
            }
            UserButton {
                width: 80
                text: qsTr("Pay")
                textColor: "white"
                onClicked: root.payButtonClicked()
            }
        }
    }
    Component {
        id: itemDelegateId
        Item {
            height: priv.cardHeight
            width: priv.cardWidth
            ItemCardInBottomBar {
                height: priv.cardHeight - 10
                width: priv.cardWidth - 10
                anchors.centerIn: parent
                uuid: itemId
                name: itemName
                imageUrl: itemImage
                totalPrice: itemTotalPrice
                qttyInCart: itemQtty
                qttyInStore: itemStoreQtty
            }
        }
    }
    QtObject {
        id: priv
        readonly property int maxItemsInSummary: 5
        readonly property int cardWidth: 250
        readonly property int cardHeight: 100
    }
}
