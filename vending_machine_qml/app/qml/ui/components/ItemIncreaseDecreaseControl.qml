import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15
import constants 1.0
import ui.theme 1.0

RowLayout {
    id: root
    spacing: Theme.spacing_sm
    property int itemQtty
    signal incrementItem
    signal decrementItem
    Item {
        visible: itemQtty === 0
        Layout.preferredHeight: 40
        Layout.preferredWidth: 40
        Layout.alignment: Qt.AlignVCenter
    }
    Button {
        visible: itemQtty > 0
        Layout.preferredHeight: 40
        Layout.preferredWidth: 40
        Layout.alignment: Qt.AlignVCenter
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
    Button {
        Layout.alignment: Qt.AlignVCenter
        Layout.preferredHeight: 40
        Layout.preferredWidth: 40
        icon {
            source: Assets.addIcon
        }
        onClicked: root.incrementItem()
    }
}
