import QtQuick 2.15
import QuickFlux 1.1
import actions 1.0
import com.cutehacks.duperagent 1.0 as Http
import "../Utils.js" as Utils

Middleware {
    function dispatch(type, message) {
        switch (type) {
        default:
            next(type, message)
            break
        }
    }
}
