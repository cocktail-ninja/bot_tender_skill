defmodule BotTenderSkill do
  use Alexa.Skill, app_id: Application.get_env(:bot_tender_skill, :app_id)
  alias Alexa.{Request, Response}
  alias BotTenderSkill.Drink

  def handle_launch(request, response) do
    what_drink_response(response)
  end

  def handle_intent("StartBotTender", _, response) do
    what_drink_response(response)
  end

  def handle_intent("OrderDrink", request, response) do
    drink = request
      |> Request.slot_value("drink")
      |> Drink.drink_with_name
    response_for_drink(response, drink)
  end

  def handle_intent("AMAZON.YesIntent", request, response) do
    question = Request.attribute(request, "question")
    handle_yes(request, response, question)
  end

  def handle_intent("AMAZON.NoIntent", request, response) do
    question = Request.attribute(request, "question")
    handle_no(request, response, question)
  end

  defp handle_yes(request, response, "GlassReady") do
    drink = request
      |> Request.attribute("drink")
      |> Drink.drink_with_name
    response
      |> say("Pouring your #{drink.name} now.")
      |> should_end_session(true)
  end

  defp handle_no(request, response, "GlassReady") do
    response
      |> copy_attributes(request)
      |> say("Sorry but I can’t pour you a drink until your glass is ready. I'll wait.")
      |> reprompt("Is your glass ready yet?")
      |> should_end_session(true)
  end

  defp response_for_drink(response, %{name: ""}) do
    response
      |> say("I’m sorry, I’ve never heard of that.")
      |> should_end_session(false)
  end

  defp response_for_drink(response, %{available: false} = drink) do
    response
      |> say("I’m sorry, I’ve never heard of a #{drink.name}.")
      |> should_end_session(false)
  end

  defp response_for_drink(response, drink) do
    response
      |> Response.set_attribute("drink", drink.name)
      |> Response.set_attribute("question", "GlassReady")
      |> say("Sure, do you have a glass ready?")
      |> should_end_session(false)
  end

  defp what_drink_response(response) do
    response
      |> say("What cocktail would you like today?")
      |> should_end_session(false)
  end

end
