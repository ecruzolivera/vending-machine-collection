import QtQuick 2.15
import Qt.labs.settings 1.1
import QuickFlux 1.1
import UUId 1.0
import actions 1.0
import "../Utils.js" as Utils

Store {
    id: root
    property var todoList: ([])
    property var todoIsNotCompleted: todoList.filter(item => !item.isCompleted)
    property var todoCompleted: todoList.filter(item => item.isCompleted)
    property var seletedItem: priv.taskSchema

    Filter {
        type: ActionTypes.taskAdd
        onDispatched: {
            console.log(ActionTypes.taskAdd, JSON.stringify(message.payload))
            const title = Utils.getSafe(message.payload)
            if (title) {
                const item = priv.makeTodo(title)
                todoList.push(item)
                todoListChanged()
            }
        }
    }

    Filter {
        type: ActionTypes.taskMarkCompleted
        onDispatched: {
            console.log(ActionTypes.taskMarkCompleted,
                        JSON.stringify(message.payload))
            const id = Utils.getSafe(message.payload.id)
            const isCompleted = Utils.getSafe(message.payload.isCompleted)
            if (id && isCompleted !== null) {
                const item = root.todoList.find(item => item.id === id)
                if (item) {
                    item.isCompleted = isCompleted
                    todoListChanged()
                }
            }
        }
    }

    Filter {
        type: ActionTypes.taskDeleted
        onDispatched: {
            console.log(ActionTypes.taskDeleted,
                        JSON.stringify(message.payload))
            const id = Utils.getSafe(message.payload.id)
            if (id) {
                const items = root.todoList.filter(item => item.id !== id)
                if (items) {
                    todoList = items
                }
            }
        }
    }

    Filter {
        type: ActionTypes.taskOpenDetail
        onDispatched: {
            console.log(ActionTypes.taskOpenDetail,
                        JSON.stringify(message.payload))
            const id = Utils.getSafe(message.payload.id)
            if (id) {
                const item = root.todoList.find(item => item.id !== id)
                if (item) {
                    root.seletedItem = item
                }
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
            return Object.assign({}, taskSchema, {
                                     "id": UUId.uuid(),
                                     "title": title
                                 })
        }
    }
}
