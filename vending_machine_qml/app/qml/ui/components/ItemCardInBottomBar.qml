import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15
import QSyncable 1.0
import actions 1.0
import constants 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0
import "../../js/Utils.js" as Utils

Rectangle {
    id: root
    radius: 15
    property string uuid
    property string name
    property url imageUrl
    property int totalPrice
    property int qttyInCart
    property int qttyInStore

    RectangularGlow {
        z: -1
        anchors.fill: parent
        glowRadius: 5
        spread: 0.2
        color: Qt.rgba(0, 0, 0, 0.1)
        cornerRadius: root.radius + glowRadius
    }

    ColumnLayout {
        spacing: 8
        anchors.centerIn: parent
        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: Theme.spacing_sm
            Label {
                horizontalAlignment: Text.AlignLeft
                font {
                    capitalization: Font.Capitalize
                    bold: true
                }
                text: name
            }
            Label {
                width: 20
                horizontalAlignment: Text.AlignLeft
                font {
                    capitalization: Font.Capitalize
                    pointSize: 14
                }
                text: `${Number(totalPrice / 100).toLocaleCurrencyString(
                          Qt.locale())}`
            }
        }
        ItemIncreaseDecreaseControl {
            Layout.alignment: Qt.AlignRight
            itemQttyInCart: qttyInCart
            itemQttyInStore: qttyInStore
            onIncrementItem: AppActions.itemIncrement(root.uuid)
            onDecrementItem: AppActions.itemDecrement(root.uuid)
        }
    }
}
