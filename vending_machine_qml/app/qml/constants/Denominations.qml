pragma Singleton

import QtQuick 2.0

QtObject {
    // Cents
    property int c10: 10
    property int c20: 20
    property int c50: 50
    property int c100: 100
    // bills
    property int b5: 5 * 100
    property int b10: 10 * 100
    property int b20: 20 * 100
    property int b50: 50 * 100
}
