import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

ColumnLayout {
    TopBar {
        Layout.fillWidth: true
        Layout.preferredHeight: 100
        Layout.alignment: Qt.AlignTop
    }
    RowLayout {
        //main view
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height
        Layout.fillWidth: true
        Layout.fillHeight: true
        Button {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            text: "exit"
            onClicked: AppActions.navigatePop()
        }
    }
    BottomBar {
        Layout.alignment: Qt.AlignBottom
        Layout.fillWidth: true
        Layout.preferredHeight: 200
    }
}
