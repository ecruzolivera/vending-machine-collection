pragma Singleton

import QtQuick 2.15
import QuickFlux 1.0

KeyTable {
    // Call it when the initialization is finished.
    // Now, it is able to start and show the application
    property string startApp
    // Call it to quit the application
    property string quitApp
    // app
    property string categorySelected
    property string itemSelected
    property string buySelected

    // navigation
    property string navigatePush
    property string navigatePop
    property string navigateReplace
}
