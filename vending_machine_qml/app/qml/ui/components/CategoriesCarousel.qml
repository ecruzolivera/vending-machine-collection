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
            width: listId.width
            height: 80
            ArrowButton {
                anchors.centerIn: parent
            }
        }
        footer: Item {
            width: listId.width
            height: 80
            ArrowButton {
                anchors.centerIn: parent
            }
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
                            Layout.preferredWidth: 60
                            Layout.preferredHeight: 60
                            source: modelData.image
                        }
                        Label {
                            Layout.alignment: Qt.AlignHCenter
                            text: modelData.category
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            AppActions.categorySelected(modelData.id)
                            listId.currentIndex = index
                        }
                    }
                }
            }
            onIsCurrentItemChanged: {
                if (isCurrentItem
                        && MainStore.items.selectedCategoryId !== modelData.id) {
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
