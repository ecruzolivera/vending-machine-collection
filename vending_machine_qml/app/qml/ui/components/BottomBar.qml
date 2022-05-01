import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Rectangle {
    //bottom
    color: Material.primaryColor
    RowLayout {
        anchors.fill: parent
        Rectangle {
            // selected item
            Layout.preferredWidth: parent.width / 3 - 20
            Layout.preferredHeight: parent.height - 20
            color: Material.backgroundColor
            ItemCard {
                height: priv.cardHeight
                width: priv.cardWidth
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
    }
}
