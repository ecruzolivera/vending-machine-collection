import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0

Row {
    spacing: Theme.spacing_sm
    TextField {
        id: enterTodoId
        width: 500
        placeholderText: qsTr("type new task name")
        focus: true
    }
    Button {
        text: qsTr("Add Task")
        enabled: enterTodoId.text.length > 0
        onClicked: AppActions.taskAdd(enterTodoId.text)
    }
}
