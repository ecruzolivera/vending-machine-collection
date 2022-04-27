pragma Singleton

import QtQuick 2.0
import QuickFlux 1.0

ActionCreator {
    signal startApp
    signal quitApp

    function taskAdd(title) {
        dispatch(ActionTypes.taskAdd, {
                     "payload": title
                 })
    }
    function taskMarkCompleted(id, isCompleted) {
        dispatch(ActionTypes.taskMarkCompleted, {
                     "payload": {
                         "id": id,
                         "isCompleted": isCompleted
                     }
                 })
    }
    function taskDeleted(id) {
        dispatch(ActionTypes.taskDeleted, {
                     "payload": id
                 })
    }
    function taskOpenDetail(id) {
        dispatch(ActionTypes.taskOpenDetail, {
                     "payload": id
                 })
    }
}
