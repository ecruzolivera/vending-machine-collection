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
    ListView {
        id: listId
        focus: true
        anchors.fill: parent
        clip: true
        spacing: 16
        model: MainStore.items.categories
        delegate: categoryDelegateId
        header: Item {
            //spacers
            height: 20
        }
        footer: Item {
            //spacers
            height: 20
        }
    }
    Component {
        id: categoryDelegateId
        Item {
            width: listId.width
            height: priv.cardHeight + 20
            property bool isCurrentItem: listId.currentIndex === index
            Item {
                width: priv.cardWidth
                height: priv.cardHeight
                anchors.centerIn: parent
                scale: isCurrentItem ? 1.2 : 0.8
                Behavior on scale {
                    ScaleAnimator {}
                }
                RectangularGlow {
                    anchors.fill: parent
                    glowRadius: 10
                    spread: 0.2
                    color: Material.accentColor
                    cornerRadius: priv.cardRadius + glowRadius
                }
                Rectangle {
                    anchors.fill: parent
                    radius: priv.cardRadius
                    color: "white"
                    border {
                        color: Material.accentColor
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
                            listId.currentIndex = index
                            AppActions.categorySelected(modelData.id)
                        }
                    }
                }
            }
            onIsCurrentItemChanged: {
                if (isCurrentItem) {
                    AppActions.categorySelected(modelData.id)
                }
            }
        }
    }
    QtObject {
        id: priv
        readonly property int cardWidth: 100
        readonly property int cardHeight: 200
        readonly property int cardRadius: 8
    }
}
