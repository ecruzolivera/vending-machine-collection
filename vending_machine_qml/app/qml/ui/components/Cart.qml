import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import constants 1.0
import stores 1.0
import ui.theme 1.0

Pane {
    width: 150
    height: 100
    RowLayout {
        anchors.centerIn: parent
        spacing: Theme.spacing_md
        Image {
            Layout.alignment: Qt.AlignVCenter
            source: Assets.shoppingCartIcon
        }
        ColumnLayout {
            Layout.alignment: Qt.AlignVCenter
            Label {
                Layout.alignment: Qt.AlignRight
                text: priv.cartItemsQtty
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: priv.cartCurrentCost
            }
        }
    }
    QtObject {
        id: priv
        property int cartItemsQtty: MainStore.items.cartItemsQtty
        property int cartCurrentCost: MainStore.items.cartCurrentCost
    }
}
