import QtQuick 2.15
import QtQml.StateMachine 1.15 as DSM

// diagram app/Forme/stores/ArmConfigFsm.png and the design is in plantuml app/Forme/stores/ArmConfigFsm.plantuml
DSM.StateMachine {
    id: root
    running: true

    initialState: armConfigInitId

    signal stateChanged(string state)

    /* Input Events */
    signal sigButtonPressed
    signal sigStow
    signal sigUnstow
    signal sigJointLocked
    signal sigJointUnlocked
    signal sigJointTransition
    signal sigPositionChanged
    signal sigStationStatus
    signal sigRequestAdjusting
    signal sigRequestAdjustingDismissed

    DSM.State {
        id: armConfigInitId
        property string name: Constants.armConfigInitState
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigStationStatus")
            signal: root.sigStationStatus
            targetState: armConfigAdjustingStateId
            guard: leftArm.isUnstowed && rightArm.isUnstowed
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigStationStatus")
            signal: root.sigStationStatus
            targetState: armConfigStowedStateId
            guard: leftArm.isStowed || rightArm.isStowed
        }
    }

    DSM.State {
        id: armConfigUnStowingStateId
        property string name: Constants.armConfigUnstowingState
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigPositionChanged")
            signal: root.sigPositionChanged
            targetState: armConfigUnStowedStateId
            guard: leftArm.isUnstowed && rightArm.isUnstowed
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigJointLocked")
            signal: root.sigJointLocked
            targetState: armConfigUnStowedStateId
            guard: leftArm.isUnstowed && rightArm.isUnstowed
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigStow")
            signal: root.sigStow
            targetState: armConfigStowingStateId
        }
    }

    DSM.State {
        id: armConfigUnStowedStateId
        property string name: Constants.armConfigUnstowedState
        onEntered: root.stateChanged(name)
        DSM.TimeoutTransition {
            targetState: armConfigAdjustingStateId
            timeout: 1000
        }
    }

    DSM.State {
        id: armConfigAdjustingStateId
        property string name: Constants.armConfigAdjustingState
        onEntered: {
            root.stateChanged(name)
            // this will trigger the transition to safe state, the transition is guarded
            root.sigJointLocked()
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigStow")
            signal: root.sigStow
            targetState: armConfigStowingStateId
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigJointLocked")
            signal: root.sigJointLocked
            targetState: armConfigSafeStateId
            // cannot not use isLocked directly because race conditions in the order in which qml evals the properties biding
            guard: leftArm.heightJointStatus === Constants.armConfigJointStatusLocked
                   && leftArm.hugJointStatus === Constants.armConfigJointStatusLocked
                   && rightArm.heightJointStatus === Constants.armConfigJointStatusLocked
                   && rightArm.hugJointStatus === Constants.armConfigJointStatusLocked
        }
    }

    DSM.State {
        id: armConfigStowingStateId
        property string name: Constants.armConfigStowingState
        onEntered: {
            root.stateChanged(name)
            // this will trigger the transition to stowed state, the transition is guarded
            root.sigPositionChanged()
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigPositionChanged")
            signal: root.sigPositionChanged
            targetState: armConfigStowedStateId
            guard: leftArm.isStowed && rightArm.isStowed
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigPositionChanged")
            signal: root.sigJointLocked
            targetState: armConfigStowedStateId
            guard: leftArm.isStowed && rightArm.isStowed
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigUnstow")
            signal: root.sigUnstow
            targetState: armConfigAdjustingStateId
            guard: leftArm.isUnstowed && rightArm.isUnstowed
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigUnstow")
            signal: root.sigUnstow
            targetState: armConfigUnStowingStateId
            guard: leftArm.isStowed || rightArm.isStowed
        }
    }

    DSM.State {
        id: armConfigStowedStateId
        property string name: Constants.armConfigStowedState
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigUnstow")
            signal: root.sigUnstow
            targetState: armConfigUnStowingStateId
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigStow")
            signal: root.sigStow
            targetState: armConfigStowingStateId
            guard: leftArm.isUnstowed || rightArm.isUnstowed
        }
    }

    DSM.State {
        id: armConfigSafeStateId
        property string name: Constants.armConfigSafeState
        onEntered: {
            root.stateChanged(name)
            // this will trigger the transition to Ready state, the transition is guarded
            root.sigJointLocked()
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigStow")
            signal: root.sigStow
            targetState: armConfigStowingStateId
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigJointUnlocked")
            signal: root.sigJointTransition
            targetState: armConfigAdjustingStateId
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigJointLocked")
            signal: root.sigJointLocked
            targetState: armConfigReadyStateId
            guard: leftArm.isOnTarget && rightArm.isOnTarget
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigRequestAdjusting")
            signal: root.sigRequestAdjusting
            targetState: armConfigAdjustingRequestedStateId
        }
    }

    DSM.State {
        id: armConfigReadyStateId
        property string name: Constants.armConfigReadyState
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigButtonPressed")
            signal: root.sigJointTransition
            targetState: armConfigAdjustingStateId
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigStow")
            signal: root.sigStow
            targetState: armConfigStowingStateId
        }
    }

    DSM.State {
        id: armConfigAdjustingRequestedStateId
        property string name: Constants.armConfigAdjustingRequestedState
        onEntered: root.stateChanged(name)
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigButtonPressed")
            signal: root.sigJointTransition
            targetState: armConfigAdjustingStateId
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigRequestAdjustingDismissed")
            signal: root.sigRequestAdjustingDismissed
            targetState: armConfigSafeStateId
        }
        DSM.SignalTransition {
            onTriggered: console.log("Transition:", "sigStow")
            signal: root.sigStow
            targetState: armConfigStowingStateId
        }
    }
}
