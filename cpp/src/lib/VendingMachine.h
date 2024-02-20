#pragma once

#include "VendingMachineFsm.h"
#include "VendingMachineOperations.h"

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

class VendingMachine
{
  public:
    explicit VendingMachine(std::initializer_list<Denomination> l);
    explicit VendingMachine(std::string_view name);
    VendingMachine();

    const std::string &name() const;

    void                          setAllowedDenominations(std::initializer_list<Denomination> l);
    const Denominations_t        &allowedDenominations() const;
    static const Denominations_t &supportedDenominations();

    std::vector<Sku_t> addItems(std::initializer_list<Item> l);

    std::optional<Item> getItem(const Sku_t &sku) const;
    std::vector<Item>   getItems(bool includeSoldOut = false) const;

    bool                    setSelectItem(const Sku_t &sku);
    std::optional<Item>     selectedItem() const;
    std::optional<Change_t> buyItem(const Sku_t &sku);

    void    insertMoney(const Denomination &c);
    Cents_t getInsertedMoneyInCents() const;

  private:
    VendingMachineOperations mOperations;
    const std::string        mName = "Unnamed";
    std::optional<Item>      mSelectedItem;
    VendingMachineFsm        mFsm;
};

enum class VendingMachineType
{
    Coffee,
    Drink,
    Snack
};

VendingMachine BuildVendingMachine(VendingMachineType type);

} // namespace VendingMachineCore
