defmodule BotTenderSkillSpec do
  use ESpec
  import Alexa.{Request, Response}

  @app_id "BotTenderSkill"

  context "launching BotTender" do

    describe "via LaunchRequest" do
      let :request, do: launch_request(@app_id)
      subject do: Alexa.handle_request(request)

      it "should respond by asking which drink you would like" do
        expect say(subject) |> to(eq "What cocktail would you like today?")
      end
      it "should not end the session" do
        expect should_end_session(subject) |> to(be_false)
      end
    end

    describe "via StartBotTender intent" do
      let :request, do: intent_request(@app_id, "StartBotTender")
      subject do: Alexa.handle_request(request)

      it "should respond by asking which drink you would like" do
        expect say(subject) |> to(eq "What cocktail would you like today?")
      end
      it "should not end the session" do
        expect should_end_session(subject) |> to(be_false)
      end
    end

  end

end
