import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15
import constants 1.0
import ui.theme 1.0

RowLayout {
    id: root
    spacing: Theme.spacing_lg
    property int itemQttyInCart
    property int itemQttyInStore
    signal incrementItem
    signal decrementItem
    AddSubButton {
        Layout.alignment: Qt.AlignVCenter
        enabled: itemQttyInCart > 0
        icon {
            color: "white"
            source: Assets.removeIcon
        }
        onClicked: root.decrementItem()
    }
    Label {
        Layout.alignment: Qt.AlignVCenter
        font.capitalization: Font.Capitalize
        text: itemQttyInCart
    }
    AddSubButton {
        Layout.alignment: Qt.AlignVCenter
        enabled: itemQttyInStore > 0
        icon {
            color: "white"
            source: Assets.addIcon
        }
        onClicked: root.incrementItem()
    }
}
