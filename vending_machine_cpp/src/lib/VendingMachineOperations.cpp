#include "VendingMachineOperations.h"

#include <algorithm>
#include <cmath>
#include <cstdlib>
#include <numeric>

using namespace VendingMachineCore;

VendingMachineOperations::VendingMachineOperations(std::initializer_list<Denomination> l)
    : mAllowedDenominations{l}
{
}

VendingMachineOperations::VendingMachineOperations()
    : mAllowedDenominations{{
        Denomination::C05,
        Denomination::C10,
        Denomination::C20,
        Denomination::C50,
        Denomination::C100,
    }}
{
}

void VendingMachineOperations::setAllowedDenominations(std::initializer_list<Denomination> l)
{
    mAllowedDenominations = Denominations_t{l};
}

const Denominations_t &VendingMachineOperations::allowedDenominations() const
{
    return mAllowedDenominations;
}

const Denominations_t &VendingMachineOperations::supportedDenominations()
{
    static const Denominations_t mSupportedDenominations = {Denomination::C05,
                                                            Denomination::C10,
                                                            Denomination::C20,
                                                            Denomination::C50,
                                                            Denomination::C100};
    return mSupportedDenominations;
}

Sku_t VendingMachineOperations::addItem(const Item &i)
{
    mSkuCounter++;
    mItems.emplace(std::make_pair(mSkuCounter,
                                  Item{.sku              = mSkuCounter,
                                       .name             = i.name,
                                       .price            = i.price,
                                       .unitsInExistence = i.unitsInExistence}));

    return mSkuCounter;
}

Sku_t VendingMachineOperations::addItem(std::string_view     name,
                                        const Cents_t       &price,
                                        const std::uint32_t &unitsInExistence)
{
    return addItem(std::forward<Item>(Item{.sku              = mSkuCounter,
                                           .name             = std::string{name},
                                           .price            = price,
                                           .unitsInExistence = unitsInExistence}));
}

Sku_t VendingMachineOperations::addItem(std::string_view     name,
                                        const float         &price,
                                        const std::uint32_t &unitsInExistence)
{
    constexpr auto TO_CENTS = 100U;

    const auto inCents = std::round(price * TO_CENTS);
    return addItem(name, static_cast<Cents_t>(inCents), unitsInExistence);
}

std::vector<Sku_t> VendingMachineOperations::addItems(std::initializer_list<Item> l)
{
    auto sku = std::vector<Sku_t>{};

    std::transform(
        l.begin(), l.end(), std::back_inserter(sku), [this](const Item &i) { return addItem(i); });

    return sku;
}

std::optional<Item> VendingMachineOperations::getItem(const Sku_t &sku) const
{
    const auto item = mItems.find(sku);
    if(item != mItems.end())
    {
        return item->second;
    }
    return {};
}

std::vector<Item> VendingMachineOperations::getItems(bool includeSoldOut) const

{
    auto allItems = std::vector<Item>{};
    std::transform(mItems.cbegin(),
                   mItems.cend(),
                   std::back_inserter(allItems),
                   [](const auto &entry) { return entry.second; });

    if(!includeSoldOut)
    {
        auto items = std::vector<Item>{};
        std::copy_if(allItems.cbegin(),
                     allItems.cend(),
                     std::back_inserter(items),
                     [](const auto &i) { return i.unitsInExistence > 0; });
        return items;
    }

    return allItems;
}

void VendingMachineOperations::insertMoney(const Denomination &c)
{
    mInsertedMoneyInCents += Denomination2Cents(c);
    mInsertedMoney.push_back(c);
}

Cents_t VendingMachineOperations::getInsertedMoneyInCents() const
{
    return mInsertedMoneyInCents;
}

bool VendingMachineOperations::isInsertedMoneyEnoughToBuyItem(const Sku_t &sku) const
{
    const auto item = getItem(sku);
    if(item)
    {
        return item->price <= mInsertedMoneyInCents;
    }
    return false;
}

Change_t VendingMachineOperations::calculateChange(const Cents_t         &amountInserted,
                                                   const Cents_t         &cost,
                                                   const Denominations_t &acceptedDenominations)
{
    auto change = Change_t{};
    if(amountInserted <= cost)
    {
        return change;
    }

    auto leftOver = amountInserted - cost;
    for(const auto &d : acceptedDenominations)
    {
        auto denominationInCents = Denomination2Cents(d);
        auto div                 = std::div(leftOver, denominationInCents);
        if(div.quot == 0)
        {
            continue;
        }
        leftOver = div.rem;
        change.emplace(d, div.quot);
    }

    return change;
}

std::optional<Change_t> VendingMachineOperations::buyItem(const Sku_t &sku)
{
    auto item = getItem(sku);
    if(!item || item->price > mInsertedMoneyInCents)
    {
        return {};
    }

    item->unitsInExistence--;
    if(item->unitsInExistence == 0)
    {
        mItems.erase(sku);
    }
    return calculateChange(mInsertedMoneyInCents, item->price, mAllowedDenominations);
}

std::optional<Cents_t> VendingMachineOperations::getItemPrice(const Sku_t &sku) const
{
    auto item = getItem(sku);
    if(!item)
    {
        return {};
    }
    return item->price;
}