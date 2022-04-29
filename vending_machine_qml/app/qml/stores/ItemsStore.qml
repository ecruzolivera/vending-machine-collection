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
    property var db: Db.db()
    property var categories: Utils.getSafe(db.categories, [])
    property var items: Utils.getSafe(db.items, [])
    property string selectedCategoryId: ""
    property var selectedCategoryItems: items.filter(
                                            item => item.categoryId === selectedCategoryId)
    property string selectedItemUuid: ""

    Filter {
        type: ActionTypes.categorySelected
        onDispatched: {
            console.log(ActionTypes.categorySelected, JSON.stringify(message))
            const uuid = Utils.getSafe(message.payload, "")
            selectedCategoryId = uuid
        }
    }

    Filter {
        type: ActionTypes.itemSelected
        onDispatched: {
            console.log(ActionTypes.itemSelected, JSON.stringify(message))
            const uuid = Utils.getSafe(message.payload, "")
            selectedItemUuid = uuid
        }
    }

    QtObject {
        id: priv
    }
}
