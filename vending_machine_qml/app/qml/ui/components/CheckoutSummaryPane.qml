import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QSyncable 1.0
import actions 1.0
import constants 1.0
import stores 1.0
import ui.theme 1.0
import ui.components 1.0

Item {
    id: root
    property var model: []
    property int cartCost: 0
    signal backButtonClicked
    signal payButtonClicked
    ColumnLayout {
        spacing: 20
        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        Label {
            Layout.alignment: Qt.AlignHCenter
            font.bold: true
            text: qsTr("Summary")
        }
        ListView {
            id: checkoutListId
            Layout.preferredHeight: priv.maxItemsInSummary * priv.itemHeight
            Layout.preferredWidth: priv.itemWidth
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            clip: true
            interactive: count > priv.maxItemsInSummary
            model: root.model
            delegate: delegateId
        }
        Row {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            spacing: 10
            Label {
                font.bold: true
                text: qsTr("Total:")
            }
            Label {
                text: `${Number(cartCost / 100).toLocaleCurrencyString(
                          Qt.locale())}`
            }
        }
        Row {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            spacing: 20
            Button {
                text: qsTr("Back")
                onClicked: root.backButtonClicked()
            }
            Button {
                text: qsTr("Pay")
                onClicked: root.payButtonClicked()
            }
        }
        Component {
            id: delegateId
            Item {
                property string itemId: modelData.id
                property int qttyInCart: modelData.qtty
                property string itemName: modelData.name
                property int totalPrice: modelData.totalPrice
                height: priv.itemHeight
                width: priv.itemWidth
                Row {
                    anchors.centerIn: parent
                    Item {
                        visible: qttyInCart === 0
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignVCenter
                    }
                    Button {
                        visible: qttyInCart > 0
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignVCenter
                        icon {
                            source: qttyInCart === 1 ? Assets.deleteIcon : Assets.removeIcon
                        }
                        onClicked: AppActions.itemDecrement(itemId)
                    }
                    Button {
                        Layout.alignment: Qt.AlignVCenter
                        Layout.preferredHeight: 40
                        Layout.preferredWidth: 40
                        icon {
                            source: Assets.addIcon
                        }
                        onClicked: AppActions.itemAdd(itemId)
                    }
                    Label {
                        text: `${qttyInCart}x ${itemName} ${Number(
                                  totalPrice / 100).toLocaleCurrencyString(
                                  Qt.locale())}`
                    }
                }
            }
        }
        QtObject {
            id: priv
            property int itemWidth: 400
            property int itemHeight: 50
            readonly property int maxItemsInSummary: 5
        }
    }
}
