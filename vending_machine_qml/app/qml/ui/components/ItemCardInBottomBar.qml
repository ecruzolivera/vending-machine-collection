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

Item {
    width: 300
    height: 100
    property string itemId
    property string itemName
    property url imageUrl
    property int totalPrice
    property int qttyInCart

    RowLayout {
        anchors.centerIn: parent
        spacing: 8
        Image {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 60
            Layout.preferredHeight: 60
            fillMode: Image.PreserveAspectFit
            source: imageUrl
        }
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: Theme.spacing_sm
            Label {
                font {
                    capitalization: Font.Capitalize
                    bold: true
                }
                text: itemName
            }
            Label {
                font {
                    capitalization: Font.Capitalize
                    bold: true
                }
                text: `(${Number(totalPrice / 100).toLocaleCurrencyString(
                          Qt.locale())})`
            }
        }
        ItemIncreaseDecreaseControl {
            itemQttyInCart: qttyInCart
            onIncrementItem: AppActions.itemIncrement(itemId)
            onDecrementItem: AppActions.itemDecrement(itemId)
        }
    }
}
