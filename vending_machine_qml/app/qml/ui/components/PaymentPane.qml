import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Item {
    id: root
    property int cartCost: 0
    property int insertedMoney: 0
    property bool areItemsDelivered: false
    property bool isMoneyReturned: false
    signal backButtonClicked
    signal cancelButtonClicked

    ColumnLayout {
        spacing: 20
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Payment")
            font.bold: true
        }
        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr(`Cart Cost: ${Number(
                           cartCost / 100).toLocaleCurrencyString(
                           Qt.locale())}`)
            font.bold: true
        }
        Label {
            Layout.alignment: Qt.AlignHCenter
            text: qsTr(`Money Inserted: ${Number(
                           insertedMoney / 100).toLocaleCurrencyString(
                           Qt.locale())}`)
        }
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 10
            Button {
                text: qsTr("Back")
                onClicked: root.backButtonClicked()
            }
            Button {
                text: qsTr("Cancel")
                onClicked: root.cancelButtonClicked()
            }
        }
        Label {
            visible: root.areItemsDelivered
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Please Pick Your Items")
        }
        Label {
            visible: root.isMoneyReturned
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Please Pick Your Change")
        }
    }
}
