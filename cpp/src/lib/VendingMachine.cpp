#include "VendingMachine.h"

#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <numeric>

namespace VendingMachineCore
{
VendingMachine::VendingMachine(std::initializer_list<Denomination> l)
    : mOperations{l}
{
}

VendingMachine::VendingMachine(std::string_view name)
    : mName{name}
{
}

VendingMachine::VendingMachine()
    : mOperations{{
        Denomination::C05,
        Denomination::C10,
        Denomination::C20,
        Denomination::C50,
        Denomination::C100,
    }}
{
}

const std::string &VendingMachine::name() const
{
    return mName;
}

const Denominations_t &VendingMachine::allowedDenominations() const
{
    return mOperations.allowedDenominations();
}

void VendingMachine::setAllowedDenominations(std::initializer_list<Denomination> l)
{
    mOperations.setAllowedDenominations(l);
}

const Denominations_t &VendingMachine::supportedDenominations()
{
    return VendingMachineOperations::supportedDenominations();
}

std::vector<Sku_t> VendingMachine::addItems(std::initializer_list<Item> l)
{
    return mOperations.addItems(l);
}

std::optional<Item> VendingMachine::getItem(const Sku_t &sku) const
{
    return mOperations.getItem(sku);
}

std::vector<Item> VendingMachine::getItems(bool includeSoldOut) const

{
    return mOperations.getItems(includeSoldOut);
}

void VendingMachine::insertMoney(const Denomination &c)
{
    mOperations.insertMoney(c);
    if(mSelectedItem)
    {
        mFsm.isInsertedMoneyEnough = mSelectedItem->price <= mOperations.getInsertedMoneyInCents();
    }
    else
    {
        mFsm.isInsertedMoneyEnough = false;
    }
    mFsm.processEvent(Event::MoneyInserted);
}

Cents_t VendingMachine::getInsertedMoneyInCents() const
{
    return mOperations.getInsertedMoneyInCents();
}

std::optional<Item> VendingMachine::selectedItem() const
{
    return mSelectedItem;
}

bool VendingMachine::setSelectItem(const Sku_t &sku)
{
    auto item = mOperations.getItem(sku);
    if(!item)
    {
        mSelectedItem = {};
        return false;
    }
    mSelectedItem              = item;
    mFsm.isItemInExistence     = mSelectedItem->unitsInExistence > 0;
    mFsm.isInsertedMoneyEnough = mSelectedItem->price <= mOperations.getInsertedMoneyInCents();
    mFsm.processEvent(Event::ItemSelected);
    return true;
}

std::optional<Change_t> VendingMachine::buyItem(const Sku_t &sku)
{
    return mOperations.buyItem(sku);
}

VendingMachine BuildVendingMachine(VendingMachineType type)
{
    using namespace VendingMachineCore;
    std::string name = "Unnamed";
    switch(type)
    {
        case VendingMachineType::Coffee:
            name = "Coffee Machine";
            break;
        case VendingMachineType::Drink:
            name = "Drink Machine";
            break;
        case VendingMachineType::Snack:
            name = "Snacks Machine";
            break;
    }

    auto       machine = VendingMachine{name};
    const auto amount  = 100;
    switch(type)
    {
        case VendingMachineType::Coffee:
            static const auto coffee =
                Item{.sku = 0, .name = "Coffee", .price = 150, .unitsInExistence = amount};
            static const auto choco =
                Item{.sku = 0, .name = "Hot Choco", .price = 100, .unitsInExistence = amount};
            static const auto hotWater =
                Item{.sku = 0, .name = "Hot Water", .price = 50, .unitsInExistence = amount};
            machine.addItems({coffee, choco, hotWater});
            machine.setAllowedDenominations({
                Denomination::C05,
                Denomination::C100,
            });
            break;
        case VendingMachineType::Drink:
            static const auto coke =
                Item{.sku = 0, .name = "Coke", .price = 120, .unitsInExistence = amount};
            static const auto water =
                Item{.sku = 0, .name = "Water", .price = 75, .unitsInExistence = amount};
            machine.addItems({coke, water});
            machine.setAllowedDenominations({
                Denomination::C05,
                Denomination::C10,
                Denomination::C20,
                Denomination::C50,
                Denomination::C100,
            });
            break;
        case VendingMachineType::Snack:
            static const auto mm =
                Item{.sku = 0, .name = "M&Ms", .price = 250, .unitsInExistence = amount};
            static const auto chips =
                Item{.sku = 0, .name = "Chips", .price = 190, .unitsInExistence = amount};
            static const auto snickers =
                Item{.sku = 0, .name = "Snickers", .price = 130, .unitsInExistence = amount};
            static const auto pantera =
                Item{.sku = 0, .name = "Pantera rosa", .price = 70, .unitsInExistence = amount};
            machine.addItems({mm, chips, snickers, pantera});
            machine.setAllowedDenominations({
                Denomination::C10,
                Denomination::C20,
                Denomination::C50,
                Denomination::C100,
            });
            break;
    }
    return machine;
}
} // namespace VendingMachineCore