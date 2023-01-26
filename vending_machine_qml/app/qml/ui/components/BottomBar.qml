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

ColumnLayout {
    id: root
    visible: !!priv.checkoutListModel.length
    Rectangle {
        color: Material.primaryColor
        Layout.fillWidth: true
        Layout.preferredHeight: 48
        Layout.leftMargin: 46
        Layout.rightMargin: 46
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

    ListView {
        id: listId
        Layout.fillWidth: true
        Layout.preferredHeight: 100
        Layout.leftMargin: 46
        Layout.rightMargin: 46
        focus: true
        orientation: ListView.Horizontal
        clip: true
        spacing: 16
        model: priv.checkoutListModel
        delegate: ItemCardInBottomBar {
            itemId: modelData.id
            itemName: modelData.name
            imageUrl: modelData.image
            productPrice: modelData.price
            qttyInCart: modelData.qtty
        }
    }
    QtObject {
        id: priv
        property int cartItemsQtty: MainStore.items.cartItemsQtty
        property int cartCurrentCost: MainStore.items.cartCurrentCost
        property var checkoutListModel: MainStore.items.cart.map(item => {
                                                                     const currentItem = MainStore.items.items.find(
                                                                         i => i.id === item.id)
                                                                     return {
                                                                         "id": currentItem.id,
                                                                         "name": currentItem.name,
                                                                         "image": currentItem.image,
                                                                         "price": currentItem.price * item.qtty,
                                                                         "qtty": item.qtty
                                                                     }
                                                                 })
    }
}
