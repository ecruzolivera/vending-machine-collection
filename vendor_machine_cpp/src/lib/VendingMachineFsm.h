#pragma once

namespace VendingMachineCore
{

enum class State
{
    Idle,
    SoldOutError,
    WaitingForMoney,
    DeliveringItem,
    ReturningChange,
    ReturningMoney,
};

enum class Event
{
    ItemSelected,
    ItemDelivered,
    MoneyDelivered,
    MoneyInserted,
    Timeout,
};

class VendingMachineFsm final
{
  public:
    State currentState() const;
    bool  isState(State state) const;
    void  processEvent(Event event);

  public:
    // guards
    bool isItemInExistence     = false;
    bool isInsertedMoneyEnough = false;

  private:
    void onIdle(Event event);
    void onSoldOutError(Event event);
    void onWaitingForMoney(Event event);
    void onDeliveringItem(Event event);
    void onReturningChange(Event event);
    void onReturningMoney(Event event);

  private:
    State mState = State::Idle;
};
} // namespace VendingMachineCore