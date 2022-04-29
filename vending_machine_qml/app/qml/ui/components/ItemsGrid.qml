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

Item {
    GridView {
        id: gridId
        focus: true
        anchors.fill: parent
        cellHeight: priv.cardHeight
        cellWidth: priv.cardWidth
        clip: true
        model: MainStore.items.selectedCategoryItems
        delegate: itemDelegateId
    }
    Component {
        id: itemDelegateId
        Item {
            width: priv.cardWidth
            height: priv.cardHeight
            //            color: "transparent"
            //            border.color: Qt.rgba(Math.random(), Math.random(),
            //                                  Math.random(), 1)
            ColumnLayout {
                anchors.centerIn: parent
                spacing: 8
                Image {
                    Layout.alignment: Qt.AlignHCenter
                    fillMode: Image.PreserveAspectFit
                    sourceSize {
                        width: 60
                        height: 60
                    }
                    source: modelData.image
                    Layout.preferredWidth: parent.width
                }
                Label {
                    Layout.alignment: Qt.AlignHCenter
                    text: modelData.name
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
                        text: Number(modelData.price/100).toLocaleCurrencyString(
                                  Qt.locale())
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    gridId.currentIndex = index
                    AppActions.itemSelected(modelData.id)
                }
            }
        }
    }
    QtObject {
        id: priv
        readonly property int cardWidth: gridId.width / 3 - 20
        readonly property int cardHeight: 200
    }
}
