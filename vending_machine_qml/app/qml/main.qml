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
import ui.components 1.0

ApplicationWindow {
    id: root
    minimumWidth: 640
    minimumHeight: 480
    width: 640
    height: 480
    visible: true
    title: MainStore.appName
    Item {
        anchors.fill: parent
        TopBar {
            id: topBarId
            height: 100
            width: parent.width
        }

        ViewStack {
            id: stackViewId
            width: parent.width
            anchors{
                top: topBarId.bottom
                bottom: parent.bottom
            }

            focus: true
            Keys.onPressed: {
                switch (event.key) {
                case Qt.Key_1:
                    AppActions.moneyInserted(Denominations.c10)
                    break
                case Qt.Key_2:
                    AppActions.moneyInserted(Denominations.c20)
                    break
                case Qt.Key_3:
                    AppActions.moneyInserted(Denominations.c50)
                    break
                case Qt.Key_4:
                    AppActions.moneyInserted(Denominations.c100)
                    break
                case Qt.Key_5:
                    AppActions.moneyInserted(Denominations.b5)
                    break
                case Qt.Key_6:
                    AppActions.moneyInserted(Denominations.b10)
                    break
                case Qt.Key_7:
                    AppActions.moneyInserted(Denominations.b20)
                    break
                case Qt.Key_8:
                    AppActions.moneyInserted(Denominations.b50)
                    break
                }
            }
        }
    }

    MiddlewareList {
        applyTarget: AppDispatcher
        ItemsMiddleware {}
        NavigationMiddleware {
            stackView: stackViewId
        }
    }
}
