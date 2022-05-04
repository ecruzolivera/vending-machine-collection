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

Item {
    width: 400
    height: 200
    property string productName
    property url imageUrl
    property int productPrice
    ColumnLayout {
        anchors.centerIn: parent
        spacing: 8
        Image {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 60
            Layout.preferredHeight: 60
            fillMode: Image.PreserveAspectFit
            source: imageUrl
        }
        Label {
            Layout.alignment: Qt.AlignHCenter
            font.capitalization: Font.Capitalize
            text: productName
        }
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 60
            Layout.preferredHeight: 25
            radius: 2

            color: "transparent"
            border {
                color: Material.accentColor
            }
            Label {
                anchors.centerIn: parent
                text: Number(productPrice / 100).toLocaleCurrencyString(
                          Qt.locale())
            }
        }
    }
}
