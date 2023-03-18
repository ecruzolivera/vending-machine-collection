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
    property int itemQtty
    signal incrementItem
    signal decrementItem
    AddSubButton {
        Layout.alignment: Qt.AlignVCenter
        enabled: itemQtty > 0
        icon {
            source: itemQtty === 1 ? Assets.deleteIcon : Assets.removeIcon
        }
        onClicked: root.decrementItem()
    }
    Label {
        Layout.alignment: Qt.AlignVCenter
        font.capitalization: Font.Capitalize
        text: itemQtty
    }
    AddSubButton {
        Layout.alignment: Qt.AlignVCenter
        icon {
            source: Assets.addIcon
        }
        onClicked: root.incrementItem()
    }
}
