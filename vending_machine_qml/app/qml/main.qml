import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QuickFlux 1.1
import QSyncable 1.0

import middlewares 1.0
import ui.pages 1.0
import ui.theme 1.0
import stores 1.0
import actions 1.0
import constants 1.0

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
        focus: true
        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_1:
                AppActions.coinInserted(Denominations.c10)
                break
            case Qt.Key_2:
                AppActions.coinInserted(Denominations.c20)
                break
            case Qt.Key_3:
                AppActions.coinInserted(Denominations.c50)
                break
            case Qt.Key_4:
                AppActions.coinInserted(Denominations.c100)
                break
            case Qt.Key_5:
                AppActions.coinInserted(Denominations.b5)
                break
            case Qt.Key_6:
                AppActions.coinInserted(Denominations.b10)
                break
            case Qt.Key_7:
                AppActions.coinInserted(Denominations.b20)
                break
            case Qt.Key_8:
                AppActions.coinInserted(Denominations.b50)
                break
            }
        }
    }

    MiddlewareList {
        applyTarget: AppDispatcher
        SystemMiddleware {}
        NavigationMiddleware {
            stackView: stackViewId
        }
    }
}
