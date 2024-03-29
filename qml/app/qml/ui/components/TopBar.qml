import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0

Pane {
    Material.background: Material.DeepOrange
    Material.foreground: "white"
    background: Rectangle {
        color: Material.backgroundColor
    }
    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        Label {
            Layout.preferredWidth: parent.width / 2
            text: qsTr("Vending Machine Logo")
        }
        RowLayout {
            spacing: 8
            Layout.alignment: Qt.AlignVCenter
            Label {
                text: new Date().toDateString(Qt.locale("es_MX"),
                                              Locale.LongFormat)
            }
            Rectangle {
                Layout.preferredWidth: 1
                Layout.preferredHeight: 30
                color: Material.foreground
            }
            Label {
                text: new Date().toLocaleTimeString(Qt.locale(),
                                                    Locale.ShortFormat)
                font {
                    pixelSize: 30
                    bold: true
                }
            }
        }
    }
}
