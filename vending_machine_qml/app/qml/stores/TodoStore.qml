import QtQuick 2.15
import Qt.labs.settings 1.1
import QuickFlux 1.1
import UUId 1.0
import actions 1.0
import "../Utils.js" as Utils

Store {
    id: root
    property var todoList: ([])

    Filter {
        type: ActionTypes.taskAdd
        onDispatched: {
            const title = Utils.getSafe(message.payload)
            if (title) {
                todoList.push(priv.makeTodo(title))
            }
        }
    }

    QtObject {
        id: priv
        readonly property var taskSchema: ({
                                               "id": 0,
                                               "title": "",
                                               "details": "",
                                               "isCompleted": false
                                           })
        function makeTodo(title) {
            return Object.assign(taskSchema, {
                                     "id": UUId.uuid(),
                                     "title": title
                                 })
        }
    }
}
