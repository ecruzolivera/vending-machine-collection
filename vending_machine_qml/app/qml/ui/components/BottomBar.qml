import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0
import "../../Utils.js" as Utils

Rectangle {
    //bottom
    id: root
    color: Material.primaryColor
    RowLayout {
        anchors.centerIn: parent
        visible: !!priv.selectedItem
        Pane {
            // selected item
            Layout.preferredWidth: root.width / 3 - 20
            Layout.preferredHeight: root.height - 20
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 8
                Label {
                    Layout.alignment: Qt.AlignHCenter
                    font {
                        pixelSize: 20
                        capitalization: Font.Capitalize
                    }
                    text: Utils.getSafe(() => priv.selectedItem.name, "")
                }
                Image {
                    Layout.alignment: Qt.AlignHCenter
                    fillMode: Image.PreserveAspectFit
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 100
                    source: Utils.getSafe(() => priv.selectedItem.image, "")
                }
            }
        }
        Pane {
            // selected item nutritional
            id: nutritionalFactsPaneId
            Layout.preferredWidth: root.width / 3 - 20
            Layout.preferredHeight: root.height - 20
            ColumnLayout {
                Label {
                    font {
                        pixelSize: 15
                        bold: true
                    }
                    text: qsTr("Ingredients")
                }
                Label {
                    Layout.preferredWidth: nutritionalFactsPaneId.width - 20
                    Layout.fillHeight: true
                    font {
                        pixelSize: 14
                    }
                    wrapMode: Text.WordWrap
                    text: Utils.getSafe(() => priv.selectedItem.description, "")
                }
            }
        }
        Pane {
            // selected item buy area
            Layout.preferredWidth: root.width / 3 - 20
            Layout.preferredHeight: root.height - 20
            RowLayout {
                anchors.centerIn: parent
                spacing: 10
                Label {
                    font {
                        pixelSize: 15
                        bold: true
                    }
                    text: qsTr("Price")
                }
                PriceBox {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredHeight: 25
                    Layout.preferredWidth: 60
                    priceInCets: Utils.getSafe(() => priv.selectedItem.price, 0)
                }
                Button {
                    text: qsTr("Buy")
                    onClicked: AppActions.buySelected(
                                   Utils.getSafe(() => priv.selectedItem.id, 0))
                }
            }
        }
    }

    QtObject {
        id: priv
        readonly property int cardWidth: 300
        readonly property int cardHeight: 200
        property var selectedItem: MainStore.items.selectedItem
    }
}
