import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

ColumnLayout {
    TopBar {
        Layout.fillWidth: true
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: 100
        Layout.minimumHeight: 80
        Layout.alignment: Qt.AlignTop
    }
    RowLayout {
        //main view
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height
        Layout.fillWidth: true
        Layout.fillHeight: true
        CategoriesCarousel {
            Layout.fillHeight: true
            Layout.preferredHeight: parent.height
        }
        Rectangle {
            // items
            Layout.preferredWidth: parent.width * 3 / 4
            Layout.preferredHeight: parent.height
            Layout.fillHeight: true
            color: "lightsalmon"
        }
    }
    RowLayout {
        //bottom
        Layout.fillWidth: true
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: 200
        Layout.minimumHeight: 150
        Layout.alignment: Qt.AlignBottom
        Rectangle {
            // selected item
            Layout.preferredWidth: parent.width / 3
            Layout.preferredHeight: parent.height
            color: "green"
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
}
