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
    width: 400
    height: 200
    property string itemId
    property string itemName
    property url imageUrl
    property int productPrice
    property int existences
    property int qttyInCart
    ColumnLayout {
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
                text: `(${Number(productPrice / 100).toLocaleCurrencyString(
                          Qt.locale())})`
            }
        }
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: Theme.spacing_sm
            Label {
                text: qsTr("Existences:")
            }
            Label {
                font.capitalization: Font.Capitalize
                text: existences
            }
        }
        RowLayout {
            spacing: Theme.spacing_sm
            Item {
                visible: qttyInCart === 0
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                Layout.alignment: Qt.AlignVCenter
            }
            Button {
                visible: qttyInCart > 0
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                Layout.alignment: Qt.AlignVCenter
                icon {
                    source: qttyInCart === 1 ? Assets.deleteIcon : Assets.removeIcon
                }
                onClicked: AppActions.itemRemoveFromCart(itemId)
            }
            Label {
                Layout.alignment: Qt.AlignVCenter
                font.capitalization: Font.Capitalize
                text: qttyInCart
            }
            Button {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredHeight: 40
                Layout.preferredWidth: 40
                icon {
                    source: Assets.addIcon
                }
                onClicked: AppActions.itemAddToCart(itemId)
            }
        }
    }
}
