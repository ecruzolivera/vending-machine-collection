import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0
import "../../Utils.js" as Utils

Rectangle {
    radius: 2
    color: "transparent"
    border {
        color: Material.accentColor
    }
    property int priceInCets: 0
    Label {
        anchors.centerIn: parent
        text: Number(priceInCets / 100).toLocaleCurrencyString(Qt.locale())
    }
}
