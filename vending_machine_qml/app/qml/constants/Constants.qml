pragma Singleton

import QtQuick 2.0
import QuickFlux 1.0

KeyTable {
    property string stateIdle
    property string stateSoldOutError
    property string stateWaitingForMoney
    property string stateDeliveringItem
    property string stateReturningChange
    property string stateReturningMoney
}

