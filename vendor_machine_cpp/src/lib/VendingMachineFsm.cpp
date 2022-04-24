
#include "VendingMachineFsm.h"

using namespace VendingMachineCore;

State VendingMachineFsm::currentState() const
{
    return mState;
}

bool VendingMachineFsm::isState(State state) const
{
    return mState == state;
}

void VendingMachineFsm::processEvent(Event event)
{
    switch(mState)
    {
        case State::Idle:
            onIdle(event);
            break;
        case State::SoldOutError:
            onSoldOutError(event);
            break;
        case State::WaitingForMoney:
            onWaitingForMoney(event);
            break;
        case State::DeliveringItem:
            onDeliveringItem(event);
            break;
        case State::ReturningChange:
            onReturningChange(event);
            break;
        case State::ReturningMoney:
            onReturningMoney(event);
            break;
    }
}

void VendingMachineFsm::onIdle(Event event)
{
    if(event == Event::ItemSelected)
    {
        mState = isItemInExistence ? State::WaitingForMoney : State::SoldOutError;
    }
}

void VendingMachineFsm::onSoldOutError(Event event)
{
    if(event == Event::Timeout)
    {
        mState = State::Idle;
    }
}

void VendingMachineFsm::onWaitingForMoney(Event event)
{
    if(event == Event::Timeout)
    {
        mState = State::ReturningMoney;
    }
    else if(event == Event::MoneyInserted && isInsertedMoneyEnough)
    {
        mState = State::DeliveringItem;
    }
}

void VendingMachineFsm::onDeliveringItem(Event event)
{
    if(event == Event::ItemDelivered)
    {
        mState = State::ReturningChange;
    }
}

void VendingMachineFsm::onReturningChange(Event event)
{
    if(event == Event::MoneyDelivered)
    {
        mState = State::Idle;
    }
}

void VendingMachineFsm::onReturningMoney(Event event)
{
    if(event == Event::MoneyDelivered)
    {
        mState = State::Idle;
    }
}
