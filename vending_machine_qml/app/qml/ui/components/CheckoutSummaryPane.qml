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

ColumnLayout {
    id: root
    spacing: 20
    property var model: []
    Label {
        text: qsTr("Summary")
        Layout.alignment: Qt.AlignHCenter
    }
    ListView {
        id: checkoutListId
        Layout.preferredHeight: count * priv.itemHeight
        Layout.preferredWidth: priv.itemWidth
        Layout.alignment: Qt.AlignHCenter
        delegate: delegateId
        model: root.model
        clip: true
    }
    Row {
        spacing: 20
        Layout.alignment: Qt.AlignHCenter
        Button {
            text: qsTr("Back")
            onClicked: AppActions.navigatePop()
        }
        Button {
            text: qsTr("Pay")
            onClicked: AppActions.payItems()
        }
    }
    Component {
        id: delegateId
        Rectangle {
            height: priv.itemHeight
            width: priv.itemWidth
            border.color: "black"
            Row {
                anchors.centerIn: parent
                Label {
                    text: modelData.name
                }
                Label {
                    text: "x" + modelData.qtty
                }
                Label {
                    text: ":" + modelData.totalPrice
                }
            }
        }
    }
    QtObject {
        id: priv
        property int itemWidth: 400
        property int itemHeight: 100
    }
}
