import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Pane {
    id: root
    SwipeView {
        anchors.fill: parent
        CheckoutSummaryPane {
            model: priv.checkoutListModel
        }
        PaymentPane {}
    }
    QtObject {
        id: priv
        property var checkoutListModel: MainStore.items.cart.map(item => {
                                                                     const currentItem = MainStore.items.items.find(
                                                                         i => i.id === item.id)
                                                                     return {
                                                                         "name": currentItem.name,
                                                                         "totalPrice": currentItem.price * item.qtty,
                                                                         "qtty": item.qtty
                                                                     }
                                                                 })
    }
}
