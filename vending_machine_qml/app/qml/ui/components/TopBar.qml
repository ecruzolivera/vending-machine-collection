import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0

Item {
    Pane {
        Material.background: "darkturquoise"
        width: parent.width
        height: parent.height
        RowLayout {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            Label {
                Layout.preferredWidth: parent.width / 2
                text: qsTr("Vending Machine Logo")
            }
            RowLayout {
                spacing: 16
                Layout.alignment: Qt.AlignVCenter
                ColumnLayout {
                    Layout.alignment: Qt.AlignVCenter
                    Label {
                        Layout.alignment: Qt.AlignRight
                        text: qsTr("Monday")
                    }
                    Label {
                        text: qsTr("15-07-2016")
                    }
                }
                Rectangle {
                    Layout.preferredWidth: 2
                    Layout.preferredHeight: parent.height * 2 / 3
                    height: 200
                    color: "gray"
                }
                Label {
                    text: qsTr("15:24")
                    font {
                        pixelSize: 22
                        bold: true
                    }
                }
            }
        }
    }
}
