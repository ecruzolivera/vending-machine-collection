#pragma once

#include <VendingMachine.h>
#include <fmt/format.h>
#include <functional>
#include <iostream>
#include <iterator>
#include <sstream>

using SelectItemTable = std::vector<std::pair<std::uint16_t, VendingMachineCore::Item>>;

bool        RunMachine(VendingMachineCore::VendingMachine &machine);

std::string SelectItemTableToString(const SelectItemTable &items);
void        DisplayMachineWelcomeMsg(const VendingMachineCore::VendingMachine &machine,
                                     const SelectItemTable                    &itemsTable);


std::string join(const std::vector<std::string> &strings, std::string_view delim);

std::string CentsToString(const VendingMachineCore::Cents_t &c);

std::string              ChangeToString(const VendingMachineCore::Change_t &c);
VendingMachineCore::Item GetUserSelectedItem(const std::string     &msg,
                                             const SelectItemTable &options);

VendingMachineCore::Cents_t GetUserInsertedMoney(VendingMachineCore::VendingMachine &machine);

template <typename T>
auto BuildSelectTable(const T &options)
{
    using SelectTable   = std::vector<std::pair<std::uint16_t, typename T::value_type>>;
    auto optionsToItem  = SelectTable{};
    auto optionsCounter = 1;
    std::transform(options.cbegin(),
                   options.cend(),
                   std::back_inserter(optionsToItem),
                   [&optionsCounter](const auto &option) {
                       return std::pair{optionsCounter++, option};
                   });
    return optionsToItem;
}