defmodule BotTenderSkill.Drink do
  alias BotTenderSkill.Drink

  defstruct [:name, available: true]

  def drinks do
    [
      %Drink{name: "Long Island Iced Tea"},
      %Drink{name: "Rum and Coke"},
      %Drink{name: "Whiskey Sour"}
    ]
  end

  def drink_with_name(name) do
    Enum.find(
      drinks,
      %Drink{name: name || "", available: false},
      fn(d) -> d.name == name end
    )
  end

end
