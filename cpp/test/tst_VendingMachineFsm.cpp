#include <VendingMachineFsm.h>
#include <catch2/catch.hpp>

TEST_CASE("FSM", "[FSM]")
{
    using namespace VendingMachineCore;

    VendingMachineFsm fsm;

    SECTION("Idle after creation")
    {
        REQUIRE(fsm.isState(State::Idle));
    }

    SECTION("Buy an item")
    {
        fsm.isItemInExistence = true;
        fsm.processEvent(Event::ItemSelected);
        REQUIRE(fsm.isState(State::WaitingForMoney));
        fsm.processEvent(Event::MoneyInserted);
        REQUIRE(fsm.isState(State::WaitingForMoney));
        fsm.isInsertedMoneyEnough = true;
        fsm.processEvent(Event::MoneyInserted);
        REQUIRE(fsm.isState(State::DeliveringItem));
        fsm.processEvent(Event::ItemDelivered);
        REQUIRE(fsm.isState(State::ReturningChange));
        fsm.processEvent(Event::MoneyDelivered);
        REQUIRE(fsm.isState(State::Idle));
    }
}
