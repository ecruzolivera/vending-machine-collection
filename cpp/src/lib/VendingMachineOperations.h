#pragma once

#include "VendingMachineFsm.h"

#include <cstdint>
#include <functional>
#include <map>
#include <optional>
#include <set>
#include <string>
#include <string_view>
#include <unordered_map>
#include <vector>

namespace VendingMachineCore
{

enum class Denomination;
struct Item;

using Cents_t         = std::int32_t;
using Sku_t           = std::uint32_t;
using Denominations_t = std::set<Denomination, std::greater<Denomination>>;
using InsertedCoins_t = std::vector<Denomination>;
using ItemsDb_t       = std::map<Sku_t, Item>;
using Change_t        = std::map<Denomination, std::uint16_t, std::greater<Denomination>>;

enum class Denomination
{
    C05  = 5,
    C10  = 10,
    C20  = 20,
    C50  = 50,
    C100 = 100,
};

inline int Denomination2Cents(Denomination d)
{
    return static_cast<int>(d);
}

inline Cents_t operator+(const Denomination &left, const Denomination &right)
{
    return Denomination2Cents(left) + Denomination2Cents(right);
}

struct Item
{
    Sku_t         sku;
    std::string   name;
    Cents_t       price;
    std::uint32_t unitsInExistence;
};

class VendingMachineOperations
{
  public:
    explicit VendingMachineOperations(std::initializer_list<Denomination> l);
    VendingMachineOperations();

    void                          setAllowedDenominations(std::initializer_list<Denomination> l);
    const Denominations_t        &allowedDenominations() const;
    static const Denominations_t &supportedDenominations();

    Sku_t addItem(const Item &i);
    Sku_t addItem(std::string_view     name,
                  const Cents_t       &price,
                  const std::uint32_t &unitsInExistence);
    Sku_t addItem(std::string_view name, const float &price, const std::uint32_t &unitsInExistence);

    std::vector<Sku_t> addItems(std::initializer_list<Item> l);

    std::optional<Item>    getItem(const Sku_t &sku) const;
    std::optional<Cents_t> getItemPrice(const Sku_t &sku) const;
    std::vector<Item>      getItems(bool includeSoldOut = false) const;

    std::optional<Change_t> buyItem(const Sku_t &sku);

    void    insertMoney(const Denomination &c);
    Cents_t getInsertedMoneyInCents() const;
    bool    isInsertedMoneyEnoughToBuyItem(const Sku_t &sku) const;

    static Change_t calculateChange(const Cents_t         &amountInserted,
                                    const Cents_t         &cost,
                                    const Denominations_t &acceptedDenominations);

  private:
    Denominations_t mAllowedDenominations;
    Sku_t           mSkuCounter           = 0;
    InsertedCoins_t mInsertedMoney        = {};
    Cents_t         mInsertedMoneyInCents = 0;
    ItemsDb_t       mItems                = {};
};
} // namespace VendingMachineCore
