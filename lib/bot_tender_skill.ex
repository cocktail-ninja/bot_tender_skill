defmodule BotTenderSkill do
  use Alexa.Skill, app_id: Application.get_env(:bot_tender_skill, :app_id)

  def handle_intent("StartBotTender", _, response) do
    what_drink_response(response)
  end

  def handle_launch(request, response) do
    what_drink_response(response)
  end

  defp what_drink_response(response) do
    response
      |> say("What cocktail would you like today?")
      |> should_end_session(false)
  end

end
