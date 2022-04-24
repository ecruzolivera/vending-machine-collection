#include <VendingMachineOperations.h>
#include <catch2/catch.hpp>

TEST_CASE("Vending Machine with all denomination", "[VendingMachineModel]")
{
    using namespace VendingMachineCore;
    VendingMachineOperations machine{Denomination::C20,
                                     Denomination::C10,
                                     Denomination::C05,
                                     Denomination::C100,
                                     Denomination::C50};
    const auto              &denominations = machine.allowedDenominations();
    auto                     prev          = Denomination::C100;

    SECTION("Accepted denominations sorted after creation")
    {
        for(const auto &c : denominations)
        {
            CHECK(prev >= c);
            prev = c;
        }
    }

    SECTION("Adding item and retrieve it")
    {
        constexpr auto name         = std::string_view{"Coffee"};
        constexpr auto price        = 1.0F;
        constexpr auto priceInCents = static_cast<Cents_t>(price * 100);
        constexpr auto units        = 50U;
        auto           sku          = machine.addItem(name, price, units);
        auto           item         = machine.getItem(sku);
        CHECK(item);
        if(item)
        {
            CHECK(item->sku == sku);
            CHECK(item->name == name);
            CHECK(item->price == priceInCents);
            CHECK(item->unitsInExistence == units);
        }
    }

    SECTION("Add item and coins and check if is enough to buy")
    {
        constexpr auto name  = std::string_view{"Coffee"};
        constexpr auto price = 1.0F;
        constexpr auto units = 50U;
        auto           sku   = machine.addItem(name, price, units);
        machine.insertMoney(Denomination::C20);
        CHECK_FALSE(machine.isInsertedMoneyEnoughToBuyItem(sku));
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C20);
        machine.insertMoney(Denomination::C10);
        CHECK(machine.isInsertedMoneyEnoughToBuyItem(sku));
    }
}

TEST_CASE("Calculate change", "[VendingMachineModel, Calculation, Change]")
{
    using namespace VendingMachineCore;
    VendingMachineOperations machine{Denomination::C20,
                                     Denomination::C10,
                                     Denomination::C05,
                                     Denomination::C100,
                                     Denomination::C50};
    SECTION("Is not enough")
    {
        constexpr auto amount = 50;
        constexpr auto price  = 100;
        auto           change = VendingMachineOperations::calculateChange(
            amount, price, machine.allowedDenominations());
        CHECK(change.empty());
    }
    SECTION("Is exact change")
    {
        constexpr auto amount = 100;
        constexpr auto price  = 100;
        auto           change = VendingMachineOperations::calculateChange(
            amount, price, machine.allowedDenominations());
        CHECK(change.empty());
    }
    SECTION("Change=1x50c")
    {
        constexpr auto amount = 150;
        constexpr auto price  = 100;
        auto           change = VendingMachineOperations::calculateChange(
            amount, price, machine.allowedDenominations());
        const auto expected = Change_t{{Denomination::C50, 1}};
        CHECK(change == expected);
    }
    SECTION("Change=1x100c")
    {
        constexpr auto amount = 200;
        constexpr auto price  = 100;
        auto           change = VendingMachineOperations::calculateChange(
            amount, price, machine.allowedDenominations());
        const auto expected = Change_t{{Denomination::C100, 1}};
        CHECK(change == expected);
    }
    SECTION("Change=[1x100c,1x50c,2x20c]")
    {
        constexpr auto amount = 200;
        constexpr auto price  = 10;
        auto           change = VendingMachineOperations::calculateChange(
            amount, price, machine.allowedDenominations());
        const auto expected =
            Change_t{{Denomination::C100, 1}, {Denomination::C50, 1}, {Denomination::C20, 2}};
        CHECK(change == expected);
    }
}

TEST_CASE("Vending Machine with all denominations", "[VendingMachineModel, buy, items, change]")
{
    using namespace VendingMachineCore;
    VendingMachineOperations machine{Denomination::C20,
                                     Denomination::C10,
                                     Denomination::C05,
                                     Denomination::C100,
                                     Denomination::C50};

    SECTION("Add item and exact coins, and check that change is empty")
    {
        constexpr auto name  = std::string_view{"Coffee"};
        constexpr auto price = 1.0F;
        constexpr auto units = 50U;
        auto           sku   = machine.addItem(name, price, units);
        machine.insertMoney(Denomination::C20);
        {
            const auto change = machine.buyItem(sku);
            CHECK_FALSE(change);
        }
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C20);
        machine.insertMoney(Denomination::C10);
        {
            const auto change = machine.buyItem(sku);
            CHECK(change);
            CHECK(change->empty());
        }
    }

    SECTION("Add item and exact coins, and check that change")
    {
        constexpr auto name  = std::string_view{"Coffee"};
        constexpr auto price = 1.0F;
        constexpr auto units = 50U;
        auto           sku   = machine.addItem(name, price, units);
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C50);
        {
            const auto change = machine.buyItem(sku);
            CHECK(change);

            const auto expected = Change_t{
                {Denomination::C100, 1},
            };
            CHECK(change == expected);
        }
    }
}

TEST_CASE("Vending Machine with reduced denominations", "[VendingMachineModel, buy, items, change]")
{
    using namespace VendingMachineCore;
    VendingMachineOperations machine{
        Denomination::C20, Denomination::C10, Denomination::C05, Denomination::C50};

    SECTION("Add item and exact coins, and check that change is empty")
    {
        constexpr auto name  = std::string_view{"Coffee"};
        constexpr auto price = 1.0F;
        constexpr auto units = 50U;
        auto           sku   = machine.addItem(name, price, units);
        machine.insertMoney(Denomination::C20);
        {
            const auto change = machine.buyItem(sku);
            CHECK_FALSE(change);
        }
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C20);
        machine.insertMoney(Denomination::C10);
        {
            const auto change = machine.buyItem(sku);
            CHECK(change);
            CHECK(change->empty());
        }
    }

    SECTION("Add item and exact coins, and check that change")
    {
        constexpr auto name  = std::string_view{"Coffee"};
        constexpr auto price = 1.0F;
        constexpr auto units = 50U;
        auto           sku   = machine.addItem(name, price, units);
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C50);
        machine.insertMoney(Denomination::C50);
        {
            const auto change = machine.buyItem(sku);
            CHECK(change);
            const auto expected = Change_t{
                {Denomination::C50, 2},
            };
            CHECK(change == expected);
        }
    }
}
