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
        cellHeight: priv.cardHeight
        cellWidth: priv.cardWidth
        clip: true
        model: MainStore.items.selectedCategoryItems
        delegate: itemDelegateId
    }
    Component {
        id: itemDelegateId
        ItemCard {
            height: priv.cardHeight
            width: priv.cardWidth
            productName: modelData.name
            imageUrl: modelData.image
            productPrice: modelData.price
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    gridId.currentIndex = index
                    AppActions.itemSelected(modelData.id)
                }
            }
        }
    }

    QtObject {
        id: priv
        readonly property int cardWidth: gridId.width / 3 - 20
        readonly property int cardHeight: 200
    }
}
