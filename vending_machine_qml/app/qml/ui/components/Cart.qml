import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import constants 1.0
import stores 1.0
import ui.theme 1.0

Pane {
    width: 100
    height: 60
    visible: priv.cartItemsQtty > 0
    ColumnLayout {
        anchors.centerIn: parent
        spacing: Theme.spacing_md
        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: Theme.spacing_md
            Image {
                Layout.alignment: Qt.AlignVCenter
                source: Assets.shoppingCartIcon
            }
            Label {
                text: priv.cartItemsQtty
            }
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: Number(priv.cartCurrentCost / 100).toLocaleCurrencyString(
                      Qt.locale())
        }
    }
    QtObject {
        id: priv
        property int cartItemsQtty: MainStore.items.cartItemsQtty
        property int cartCurrentCost: MainStore.items.cartCurrentCost
    }
}
