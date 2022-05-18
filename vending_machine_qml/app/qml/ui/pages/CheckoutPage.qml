import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Pane {
    Button {
        anchors.centerIn: parent
        text: "exit"
        onClicked: AppActions.navigatePop()
    }
}