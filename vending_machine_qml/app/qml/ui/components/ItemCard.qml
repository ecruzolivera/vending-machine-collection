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
    property string itemId
    property string itemName
    property url imageUrl
    property int productPrice
    property int existences
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
        anchors.centerIn: parent
        spacing: 8
        Image {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.preferredWidth: 60
            Layout.preferredHeight: 60
            fillMode: Image.PreserveAspectFit
            source: imageUrl
            WireFrame {}
        }
        Label {
            WireFrame {}
            Layout.alignment: Qt.AlignHCenter
            font {
                capitalization: Font.Capitalize
                bold: true
            }
            text: itemName
        }
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: Theme.spacing_sm
            Label {
                font {
                    capitalization: Font.Capitalize
                    bold: true
                }
                color: Material.primaryColor
                text: `${Number(productPrice / 100).toLocaleCurrencyString(
                          Qt.locale())}`
            }
            Label {
                font.capitalization: Font.Capitalize
                text: "/"
            }
            Label {
                color: Material.color(Material.Grey)
                text: `${qttyInStore} pcs`
            }
        }
        ItemIncreaseDecreaseControl {
            itemQttyInCart: qttyInCart
            itemQttyInStore: qttyInStore
            onIncrementItem: AppActions.itemIncrement(itemId)
            onDecrementItem: AppActions.itemDecrement(itemId)
        }
    }
}
