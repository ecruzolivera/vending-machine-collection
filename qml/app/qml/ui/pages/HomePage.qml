import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Item {
    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            //main view
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height
            Layout.fillWidth: true
            Layout.fillHeight: true
            CategoriesCarousel {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredWidth: parent.width / 4
                Layout.preferredHeight: parent.height
                Layout.fillHeight: true
            }
            ItemsGrid {
                Layout.fillHeight: true
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.width * 3 / 4
            }
        }
        BottomBar {
            id: bbar
            Layout.alignment: Qt.AlignBottom
            Layout.fillWidth: true
            Layout.preferredHeight: 200
        }
    }
    // Timer {
    // running: true
    // interval: 400
    // onTriggered: {
    // AppActions.itemIncrement("1")
    // AppActions.itemIncrement("1")
    // AppActions.checkoutCart()
    // AppActions.itemIncrement("3")
    // AppActions.itemIncrement("3")
    // AppActions.itemIncrement("4")
    // AppActions.itemIncrement("2")
    // AppActions.itemIncrement("6")
    // AppActions.itemIncrement("8")
    // }
    // }
}
