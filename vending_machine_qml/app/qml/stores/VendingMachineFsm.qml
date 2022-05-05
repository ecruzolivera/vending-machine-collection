import QtQuick 2.15
import QtQml.StateMachine 1.15 as DSM
import constants 1.0

// diagram app/Forme/stores/ArmConfigFsm.png and the design is in plantuml app/Forme/stores/ArmConfigFsm.plantuml
DSM.StateMachine {
    id: root
    running: true
    initialState: stateIdleId
    property bool isEnough: false

    signal stateChanged(string state)
    /* Input Events */
    signal sigBuy
    signal sigMoneyInserted
    signal sigTimeout
    signal sigItemDelivered
    signal sigMoneyDelivered

    DSM.State {
        id: stateIdleId
        readonly property string name: Constants.stateIdle
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            signal: sigBuy
            targetState: stateWaitingForMoneyId
            onTriggered: console.log("Transition:", "sigBuy")
        }
    }
    DSM.State {
        id: stateWaitingForMoneyId
        readonly property string name: Constants.stateWaitingForMoney
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            signal: sigMoneyInserted
            targetState: stateDeliveringItemId
            guard: isEnough
            onTriggered: console.log("Transition:", "sigMoneyInserted")
        }
        DSM.TimeoutTransition{
            timeout: 20*60
            targetState: stateIdleId
        }
    }
    DSM.State {
        id: stateDeliveringItemId
        readonly property string name: Constants.stateDeliveringItem
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            signal: sigItemDelivered
            targetState: stateReturningChangeId
            onTriggered: console.log("Transition:", "sigItemDelivered")
        }
    }
    DSM.State {
        id: stateReturningChangeId
        readonly property string name: Constants.stateReturningChange
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            signal: sigMoneyDelivered
            targetState: stateIdleId
            onTriggered: console.log("Transition:", "sigMoneyDelivered")
        }
    }
    DSM.State {
        id: stateReturningMoneyId
        readonly property string name: Constants.stateReturningMoney
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            signal: sigMoneyDelivered
            targetState: stateIdleId
            onTriggered: console.log("Transition:", "sigMoneyDelivered")
        }
    }
}
