#include <VendingMachine.h>
#include <fmt/format.h>

#include <functional>
#include <internal_use_only/config.hpp>
#include <iostream>
#include <iterator>
#include <sstream>

#include "Cli.h"

using namespace VendingMachineCore;

static constexpr auto USAGE =
  R"(Hello, select the desired Vending Machine:
    1) Coffee Machine
    2) Drink Machine
    3) Snack Machine
)";

int main(int argc, const char **argv) {
  (void)argc;
  (void)argv;

  static const auto validOptions = std::map<int, VendingMachineType>{{1, VendingMachineType::Coffee},
                                                                     {2, VendingMachineType::Drink},
                                                                     {3, VendingMachineType::Snack}};
  int option = 0;
  auto validOptionEntered = false;
  do {
    fmt::print(USAGE);
    std::cin >> option;
    validOptionEntered = std::any_of(validOptions.cbegin(), validOptions.cend(), [option](const auto &op) {
      return op.first == option;
    });

  } while (!validOptionEntered);

  auto machine = BuildVendingMachine(validOptions.at(option));
  if (!RunMachine(machine)) {
    exit(EXIT_FAILURE);
  }

  exit(EXIT_SUCCESS);
}
