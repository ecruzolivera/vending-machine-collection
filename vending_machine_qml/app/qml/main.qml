import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QuickFlux 1.1
import QSyncable 1.0

import middlewares 1.0
import ui.pages 1.0
import ui.theme 1.0
import stores 1.0

ApplicationWindow {
    minimumWidth: 640
    minimumHeight: 480
    width: 640
    height: 480
    visible: true
    title: MainStore.appName

    ViewStack {
        id: stackViewId
        anchors.fill: parent
    }

    MiddlewareList {
        applyTarget: AppDispatcher
        SystemMiddleware {}
        NavigationMiddleware {
            stackView: stackViewId
        }
    }
}
