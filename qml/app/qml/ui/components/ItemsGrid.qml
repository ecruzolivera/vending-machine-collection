import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Item {
    GridView {
        id: gridId
        focus: true
        anchors.fill: parent
        cellHeight: priv.cardHeight + 20
        cellWidth: priv.cardWidth + 20
        clip: true
        model: JsonListModel {
            keyField: "id"
            source: MainStore.items.selectedCategoryItems
        }

        delegate: itemDelegateId
    }
    Component {
        id: itemDelegateId
        Item {
            height: priv.cardHeight + 20
            width: priv.cardWidth + 20
            ItemCard {
                height: priv.cardHeight
                width: priv.cardWidth
                anchors.centerIn: parent
                itemId: id
                itemName: name
                imageUrl: image
                productPrice: price
                qttyInCart: {
                    const iD = id
                    const maybeItem = MainStore.items.cart.find(
                                        item => item.id === iD)
                    return !!maybeItem ? maybeItem.qtty : 0
                }
                qttyInStore: {
                    const iD = id
                    const maybeItem = MainStore.items.items.find(
                                        item => item.id === iD)
                    return !!maybeItem ? maybeItem.qtty : 0
                }
            }
        }
    }

    QtObject {
        id: priv
        readonly property int cardWidth: 180
        readonly property int cardHeight: 250
    }
}
