import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QSyncable 1.0
import actions 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Item {
    ListView {
        id: listId
        focus: true
        anchors.fill: parent
        clip: true
        spacing: 16
        model: MainStore.items.categories
        delegate: categoryDelegateId
        onCurrentIndexChanged: console.log("currentIndex", currentIndex)
    }
    Component {
        id: categoryDelegateId
        Item {
            width: listId.width
            height: priv.cardHeight + 20
            Rectangle {
                width: priv.cardWidth
                height: priv.cardHeight
                anchors.centerIn: parent
                scale: listId.currentIndex === index ? 1.2 : 0.8
                color: "transparent"
                Behavior on scale {
                    ScaleAnimator {
                    }
                }
                ColumnLayout {
                    anchors.centerIn: parent
                    Image {
                        Layout.alignment: Qt.AlignHCenter
                        fillMode: Image.PreserveAspectFit
                        sourceSize {
                            width: 50
                            height: 50
                        }
                        source: modelData.image
                        Layout.preferredWidth: parent.width
                    }
                    Label {
                        Layout.alignment: Qt.AlignHCenter
                        text: modelData.category
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log(index)
                        listId.currentIndex = index
                    }
                }
            }
        }
    }
    QtObject {
        id: priv
        readonly property int cardWidth: 100
        readonly property int cardHeight: 200
    }
}
