import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15
import constants 1.0
import ui.theme 1.0

Button {
    background: Rectangle {
        implicitWidth: 30
        implicitHeight: 30
        color: Material.accentColor
        opacity: {
            let o = 1
            if (!enabled) {
                o = 0.3
            } else if (pressed) {
                o = 0.5
            }
            return o
        }
        radius: 5
    }
}
