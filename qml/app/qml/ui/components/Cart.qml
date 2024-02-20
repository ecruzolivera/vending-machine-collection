import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import actions 1.0
import constants 1.0
import stores 1.0
import ui.theme 1.0

Pane {
    visible: priv.cartItemsQtty > 0
    ColumnLayout {
        spacing: Theme.spacing_md
        RowLayout {
            spacing: Theme.spacing_md
            Image {
                Layout.margins: Theme.spacing_sm
                Layout.alignment: Qt.AlignVCenter
                source: Assets.shoppingCartIcon
            }
            ColumnLayout {
                spacing: Theme.spacing_md
                Label {
                    Layout.alignment: Qt.AlignRight
                    text: priv.cartItemsQtty
                }
                Label {
                    Layout.preferredWidth: 20
                    Layout.alignment: Qt.AlignRight
                    text: Number(
                              priv.cartCurrentCost / 100).toLocaleCurrencyString(
                              Qt.locale())
                }
            }
        }
        Button {
            Layout.alignment: Qt.AlignVCenter
            text: qsTr("Checkout")
            onClicked: AppActions.checkoutCart()
        }
    }
    QtObject {
        id: priv
        property int cartItemsQtty: MainStore.items.cartItemsQtty
        property int cartCurrentCost: MainStore.items.cartCurrentCost
    }
}
