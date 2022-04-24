#include "Cli.h"

using namespace VendingMachineCore;

bool RunMachine(VendingMachine &machine)
{
    const auto itemsTable = BuildSelectTable(machine.getItems());
    DisplayMachineWelcomeMsg(machine, itemsTable);
    const auto item = GetUserSelectedItem("Please select your Item:", itemsTable);
    fmt::print("{} selected it costs: {}\n", item.name, CentsToString(item.price));
    if(!machine.setSelectItem(item.sku))
    {
        fmt::print("Could not select Item\n");
        return false;
    }
    fmt::print("Please insert {} worth of money\n", CentsToString(item.price));

    const auto userMoney = GetUserInsertedMoney(machine);
    fmt::print("You inserted {} \n", CentsToString(userMoney));
    const auto change = machine.buyItem(item.sku);
    if(change)
    {
        const auto changeTotal = userMoney - item.price;
        fmt::print("Delivering {}\n", item.name);
        if(changeTotal != 0)
        {
            fmt::print("Delivering change for {} as {}\n",
                       CentsToString(changeTotal),
                       ChangeToString(*change));
        }
        return true;
    }
    else
    {
        fmt::print("Ups!! something went wrong buying {}\n", item.name);
        return false;
    }
}

std::string SelectItemTableToString(const SelectItemTable &items)
{

    auto optionsToStr = std::vector<std::string>{};
    std::transform(items.cbegin(),
                   items.cend(),
                   std::back_inserter(optionsToStr),
                   [](const auto &itemsOp)
                   {
                       const auto &item     = itemsOp.second;
                       auto        priceStr = CentsToString(item.price);
                       return fmt::format(
                           "{}) {:^10} - price: {}", itemsOp.first, item.name, priceStr);
                   });

    return join(optionsToStr, "\n");
}

SelectItemTable BuildSelectItemTable(const VendingMachine &machine)
{

    const auto items          = machine.getItems();
    auto       optionsToItem  = SelectItemTable{};
    auto       optionsCounter = 1;
    std::transform(items.cbegin(),
                   items.cend(),
                   std::back_inserter(optionsToItem),
                   [&optionsCounter](const auto &itemsOp) {
                       return std::pair{optionsCounter++, itemsOp};
                   });
    return optionsToItem;
}

void DisplayMachineWelcomeMsg(const VendingMachine &machine, const SelectItemTable &itemsTable)
{
    static constexpr auto WELCOME =
        R"(
The {}
{}
)";
    const auto itemsStr = SelectItemTableToString(itemsTable);

    fmt::print(WELCOME, machine.name(), itemsStr);
}

std::string join(const std::vector<std::string> &strings, std::string_view delim)
{
    std::stringstream ss;
    std::copy(strings.begin(), strings.end(), std::ostream_iterator<std::string>(ss, delim.data()));
    return ss.str();
}

VendingMachineCore::Item GetUserSelectedItem(const std::string &msg, const SelectItemTable &options)
{
    std::uint16_t option             = 0;
    auto          validOptionEntered = false;
    do
    {
        fmt::print("{}\n", msg);
        std::cin >> option;
        validOptionEntered = std::any_of(options.cbegin(),
                                         options.cend(),
                                         [option](const auto &op) { return op.first == option; });
        if(!validOptionEntered)
        {
            fmt::print("Option {} is not valid\n", option);
        }

    } while(!validOptionEntered);
    auto item = std::find_if(
        options.cbegin(), options.cend(), [option](const auto &op) { return op.first == option; });
    return item->second;
}

VendingMachineCore::Cents_t GetUserInsertedMoney(VendingMachine &machine)
{
    const auto maybeSelectedItem = machine.selectedItem();
    if(!maybeSelectedItem)
    {
        fmt::print("Item not selected\n");
        return Cents_t{0};
    }
    const auto  selectedItem           = *maybeSelectedItem;
    const auto  priceToMatch           = selectedItem.price;
    const auto &supportedDenominations = machine.supportedDenominations();
    auto        selectTableStr         = std::vector<std::string>{};
    const auto  selectTable            = BuildSelectTable(supportedDenominations);

    auto selectCounter = 1;
    std::transform(selectTable.cbegin(),
                   selectTable.cend(),
                   std::back_inserter(selectTableStr),
                   [&selectCounter](const auto &option)
                   {
                       return fmt::format(
                           "{}) {}",
                           selectCounter++,
                           CentsToString(VendingMachineCore::Denomination2Cents(option.second)));
                   });

    const auto msg           = join(selectTableStr, "\t");
    auto       option        = 0U;
    auto       insertedMoney = Cents_t{0};

    do
    {
        fmt::print("{}\n", msg);
        std::cin >> option;

        const auto denominationOption =
            std::find_if(selectTable.cbegin(),
                         selectTable.cend(),
                         [option](const auto &op) { return op.first == option; });
        if(denominationOption != selectTable.cend())
        {
            const auto denomination = (*denominationOption).second;
            machine.insertMoney(denomination);
            insertedMoney = insertedMoney + Denomination2Cents(denomination);
            fmt::print("Inserted money {} \n", CentsToString(insertedMoney));
        }
        else
        {
            fmt::print("Option {} is not valid\n", option);
        }
    } while(insertedMoney < priceToMatch);
    return insertedMoney;
}

std::string CentsToString(const VendingMachineCore::Cents_t &c)
{
    static constexpr float CENTS        = 100.0;
    const auto             priceInFloat = static_cast<float>(c) / CENTS;
    return fmt::format("${:.2f}", priceInFloat);
}

std::string ChangeToString(const VendingMachineCore::Change_t &c)
{
    auto changeStr = std::vector<std::string>{};
    std::transform(c.cbegin(),
                   c.cend(),
                   std::back_inserter(changeStr),
                   [](const auto &d)
                   {
                       const auto denominationStr = CentsToString(Denomination2Cents(d.first));
                       const auto amount          = d.second;
                       return fmt::format("{}x{}", amount, denominationStr);
                   });

    return join(changeStr, "\t");
}