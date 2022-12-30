import QtQuick 2.15
import QtQml.StateMachine 1.15 as DSM
import constants 1.0

DSM.StateMachine {
    id: root
    running: true
    initialState: stateIdleId
    property bool isEnoughMoney: false
    property bool hasMoneyToBeReturned: false
    property bool isCartEmpty: false
    property string paymentEnteredState: ""
    property string paymentExitedState: ""

    signal enteredState(string state)
    signal exitedState(string state)

    /* Input Events */
    signal sigItemAddedToCart
    signal sigItemRemovedFromCart
    signal sigBuy
    signal sigMoneyInserted
    signal sigTimeout
    signal sigItemsDelivered
    signal sigMoneyReturned

    onEnteredState: {
        console.log("fsm entered state:", state)
        paymentEnteredState = state
        switch (state) {
        case FsmState.itemsInCart:
            timeoutTimerId.stop()
            timeoutTimerId.interval = 5 * 60 * 1000
            timeoutTimerId.start()
            break
        case FsmState.waitingForMoney:
            timeoutTimerId.stop()
            timeoutTimerId.interval = 2 * 60 * 1000
            timeoutTimerId.start()
            break
        }
    }
    onExitedState: {
        console.log("fsm exited state:", state)
        paymentEnteredState = state
    }

    onSigMoneyInserted: {
        if (paymentEnteredState === FsmState.waitingForMoney) {
            timeoutTimerId.restart()
        }
    }

    onSigItemAddedToCart: {
        if (paymentEnteredState === FsmState.itemsInCart) {
            timeoutTimerId.restart()
        }
    }

    Timer {
        id: timeoutTimerId
        interval: 10000
        onTriggered: root.sigTimeout()
        onRunningChanged: console.log("fsm timeout running:", running)
        onIntervalChanged: console.log("fsm timeout interval:", interval)
    }

    DSM.State {
        id: stateIdleId
        readonly property string name: FsmState.idle
        onEntered: root.enteredState(name)
        onExited: root.exitedState(name)
        DSM.SignalTransition {
            signal: sigItemAddedToCart
            targetState: stateItemsInCartId
            onTriggered: console.log("Transition:", "sigItemAddedToCart")
        }
        DSM.SignalTransition {
            signal: sigMoneyInserted
            targetState: stateReturningMoneyId
            onTriggered: console.log("Transition:", "sigMoneyInserted")
        }
    }
    DSM.State {
        id: stateItemsInCartId
        readonly property string name: FsmState.itemsInCart
        onEntered: root.enteredState(name)
        onExited: root.exitedState(name)

        DSM.SignalTransition {
            signal: sigBuy
            targetState: stateWaitingForMoneyId
            onTriggered: console.log("Transition:", "sigBuy")
        }
        DSM.SignalTransition {
            signal: sigItemRemovedFromCart
            targetState: stateIdleId
            guard: isCartEmpty
            onTriggered: console.log("Transition:", "sigItemRemovedFromCart")
        }
        DSM.SignalTransition {
            signal: sigTimeout
            targetState: stateReturningMoneyId
            guard: hasMoneyToBeReturned
            onTriggered: console.log("Transition:", "sigTimeout")
        }
        DSM.SignalTransition {
            signal: sigTimeout
            targetState: stateIdleId
            guard: !hasMoneyToBeReturned
            onTriggered: console.log("Transition:", "sigTimeout")
        }
    }
    DSM.State {
        id: stateWaitingForMoneyId
        readonly property string name: FsmState.waitingForMoney
        onEntered: root.enteredState(name)
        onExited: root.exitedState(name)
        DSM.SignalTransition {
            signal: sigMoneyInserted
            targetState: stateDeliveringItemId
            guard: isEnoughMoney
            onTriggered: console.log("Transition:", "sigMoneyInserted")
        }
        DSM.SignalTransition {
            signal: sigTimeout
            targetState: stateReturningMoneyId
            guard: hasMoneyToBeReturned
            onTriggered: console.log("Transition:", "sigTimeout")
        }
    }
    DSM.State {
        id: stateDeliveringItemId
        readonly property string name: FsmState.deliveringItem
        onEntered: root.enteredState(name)
        onExited: root.exitedState(name)
        DSM.SignalTransition {
            signal: sigItemsDelivered
            targetState: stateIdleId
            guard: !hasMoneyToBeReturned
            onTriggered: console.log("Transition:", "sigItemDelivered")
        }
        DSM.SignalTransition {
            signal: sigItemsDelivered
            targetState: stateReturningMoneyId
            guard: hasMoneyToBeReturned
            onTriggered: console.log("Transition:", "sigItemDelivered")
        }
    }
    DSM.State {
        id: stateReturningMoneyId
        readonly property string name: FsmState.returningMoney
        onEntered: root.enteredState(name)
        onExited: root.exitedState(name)
        DSM.SignalTransition {
            signal: sigMoneyReturned
            targetState: stateIdleId
            onTriggered: console.log("Transition:", "sigMoneyDelivered")
        }
    }
}
