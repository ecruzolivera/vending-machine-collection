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

Item {
    id: root
    visible: !!priv.checkoutListModel.length
    ColumnLayout {
        anchors.fill: parent
        HorizontalCartBar {
            Layout.fillWidth: true
            Layout.leftMargin: 46
            Layout.preferredHeight: 48
            Layout.rightMargin: 46
            cartCost: priv.cartCurrentCost
            onCheckoutPressed: AppActions.checkoutCart()
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
            delegate: Item {
                height: priv.cardHeight
                width: priv.cardWidth
                ItemCardInBottomBar {
                    height: priv.cardHeight - 10
                    width: priv.cardWidth - 10
                    anchors.centerIn: parent
                    itemId: modelData.id
                    itemName: modelData.name
                    imageUrl: modelData.image
                    totalPrice: modelData.totalPrice
                    qttyInCart: modelData.qtty
                    qttyInStore: modelData.storeQtty
                }
            }
        }
        QtObject {
            id: priv
            readonly property int cardWidth: 250
            readonly property int cardHeight: 100
            property int cartItemsQtty: MainStore.items.cartItemsQtty
            property int cartCurrentCost: MainStore.items.cartCurrentCost
            property var checkoutListModel: MainStore.items.cart.map(item => {
                                                                         const currentItem = MainStore.items.items.find(i => i.id === item.id)
                                                                         return {
                                                                             "id": currentItem.id,
                                                                             "name": currentItem.name,
                                                                             "image": currentItem.image,
                                                                             "totalPrice": currentItem.price * item.qtty,
                                                                             "qtty": item.qtty,
                                                                             "storeQtty": currentItem.qtty
                                                                         }
                                                                     })
        }
    }
}
