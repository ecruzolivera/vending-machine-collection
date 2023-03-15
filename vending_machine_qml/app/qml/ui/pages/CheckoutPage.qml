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

Pane {
    id: root
    SwipeView {
        id: swipeId
        anchors.fill: parent
        CheckoutSummaryPane {
            model: priv.checkoutListModel
            cartCost: MainStore.items.cartCurrentCost
            onBackButtonClicked: {
                AppActions.navigatePop()
            }
            onPayButtonClicked: {
                AppActions.payItems()
                swipeId.incrementCurrentIndex()
            }
        }
        PaymentPane {
            cartCost: MainStore.items.cartCurrentCost
            insertedMoney: MainStore.items.insertedMoneyTotal
            areItemsDelivered: priv.areItemsReturned
            isMoneyReturned: priv.isMoneyReturned
            onBackButtonClicked: {
                swipeId.decrementCurrentIndex()
            }
            onCancelButtonClicked: {
                AppActions.navigatePop()
                AppActions.cancelPayment()
            }
        }
    }
    QtObject {
        id: priv
        property var checkoutListModel: MainStore.items.cart.map(item => {
                                                                     const currentItem = MainStore.items.items.find(
                                                                         i => i.id === item.id)
                                                                     return {
                                                                         "id": currentItem.id,
                                                                         "name": currentItem.name,
                                                                         "image": currentItem.image,
                                                                         "totalPrice": currentItem.price * item.qtty,
                                                                         "qtty": item.qtty
                                                                     }
                                                                 })

        property bool areItemsReturned: MainStore.items.paymentEnteredState
                                        === FsmState.deliveringItem
        property bool isMoneyReturned: MainStore.items.paymentEnteredState
                                       === FsmState.returningMoney

        property string paymentEnteredState: MainStore.items.paymentEnteredState
        onPaymentEnteredStateChanged: {
            switch (paymentEnteredState) {
            case FsmState.idle:
                AppActions.navigatePop()
                break
            }
        }
    }
}
