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
    color: Material.primaryColor
    RowLayout {
        anchors.fill: parent
        Pane {
            // selected item
            Layout.preferredWidth: parent.width / 3
            Layout.preferredHeight: parent.height
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
                    sourceSize {
                        width: 100
                        height: 100
                    }
                    source: Utils.getSafe(() => priv.selectedItem.image, "")
                    Layout.preferredWidth: parent.width
                }
            }
        }
        Rectangle {
            // selected item description
            Layout.preferredWidth: parent.width / 3
            Layout.preferredHeight: parent.height
            color: "blue"
        }
        Rectangle {
            // buy area
            Layout.preferredWidth: parent.width / 3
            Layout.preferredHeight: parent.height
            color: "yellow"
        }
    }

    QtObject {
        id: priv
        readonly property int cardWidth: 300
        readonly property int cardHeight: 200
        property var selectedItem: MainStore.items.selectedItem
    }
}
