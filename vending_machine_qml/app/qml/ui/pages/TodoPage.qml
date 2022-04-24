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
    AddTaskBar {
        width: 500
    }

    ListView {
        id: resultsId
        anchors.fill: parent
        spacing: Theme.spacing_sm
        clip: true
        model: JsonListModel {
            keyField: "id"
            source: MainStore.todo.todoList
        }

        ScrollBar.vertical: ScrollBar {}
        delegate: searchResultId
    }

    Component {
        id: searchResultId
        RowLayout {
            spacing: Theme.spacing_sm
            Text {
                text: qsTr(title)
            }
        }
    }
}
