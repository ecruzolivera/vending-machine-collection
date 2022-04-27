import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Pane {
    property string name: qsTr("Todo List")
    Column {
        AddTaskBar {
            width: 500
        }

        ListView {
            width: 500
            height: Math.min(500, 100 * count)
            spacing: Theme.spacing_sm
            clip: true
            model: JsonListModel {
                keyField: "id"
                source: MainStore.todo.todoIsNotCompleted
            }
            ScrollBar.vertical: ScrollBar {}
            delegate: todoItemId
            header: Text {
                text: qsTr("Todo")
            }
            headerPositioning: ListView.OverlayHeader
        }

        ListView {
            width: 500
            height: Math.min(500, 100 * count)
            spacing: Theme.spacing_sm
            clip: true
            model: JsonListModel {
                keyField: "id"
                source: MainStore.todo.todoCompleted
            }
            ScrollBar.vertical: ScrollBar {}
            delegate: todoItemId
            header: Text {
                text: qsTr("Completed")
            }
            visible: count > 0
        }
    }

    Component {
        id: todoItemId
        CheckBox {
            text: model.title
            checked: model.isCompleted
            onCheckedChanged: AppActions.taskMarkCompleted(model.id, checked)
        }
    }
}
