import QtQuick 2.15
import Qt.labs.settings 1.1
import QuickFlux 1.1
import UUId 1.0
import actions 1.0
import constants 1.0
import "../Utils.js" as Utils
import "db.js" as Db

Store {
    id: root
    property var categories: Utils.getSafe(db.categories, [])
    property var items: Utils.getSafe(db.items, [])
    property var db: Db.db()
    property string categorySelectedUuid: ""

    Filter {
        type: ActionTypes.categorySelected
        onDispatched: {
            console.log(ActionTypes.categorySelected, JSON.stringify(message))
            const uuid = Utils.getSafe(message.payload, "")
            categorySelectedUuid = uuid
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
