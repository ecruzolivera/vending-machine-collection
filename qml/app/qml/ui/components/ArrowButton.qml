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

Rectangle {
    width: 40
    height: width
    radius: width / 2
    property bool isDisabled: false
    // enum OrientationType {
    // Up,
    // Right,
    // Down,
    // Left
    // }
    // property enumeration orientation: ArrowButton.OrientationType.Up
    PathPolyline {
        path: [Qt.point(10, 10), Qt.point(15, 15)]
    }
}
