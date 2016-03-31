defmodule BotTenderSkillSpec do
  use ESpec
  import Alexa.{Request, Response}
  alias Alexa.Response

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

  context "order drink" do
    describe "valid drink order" do
      let :request, do: intent_request(@app_id, "OrderDrink", nil, %{"drink" => "Long Island Iced Tea"})
      subject do: Alexa.handle_request(request)

      it "should ask the user to confirm the glass is ready" do
        expect say(subject) |> to(eq "Sure, do you have a glass ready?")
      end
      it "should store the requested drink in the session attributes" do
        expect Response.attribute(subject, "drink") |> to(eq "Long Island Iced Tea")
      end
      it "should set the question context to 'GlassReady'" do
        expect Response.attribute(subject, "question") |> to(eq "GlassReady")
      end
      it "should not end the session" do
        expect should_end_session(subject) |> to(be_false)
      end
    end

    describe "invalid drink name" do
      let :drink_name, do: "Slippery Nipple"
      let :request, do: intent_request(@app_id, "OrderDrink", nil, %{"drink" => drink_name})
      subject do: Alexa.handle_request(request)

      it "should tell the user the drink is not available" do
        expect say(subject) |> to(eq "I’m sorry, I’ve never heard of a #{drink_name}.")
      end
    end

    describe "empty drink name" do
      let :request, do: intent_request(@app_id, "OrderDrink", nil, %{"drink" => ""})
      subject do: Alexa.handle_request(request)

      it "should tell the user the drink is not available" do
        expect say(subject) |> to(eq "I’m sorry, I’ve never heard of that.")
      end
    end
  end

  context "confirm drink" do
    describe "yes" do
      let :request, do: intent_request(@app_id, "AMAZON.YesIntent", nil, nil, %{"drink" => "Long Island Iced Tea"})
      subject do: Alexa.handle_request(request)

      it "should tell the user the drink is pouring" do
        expect say(subject) |> to(eq "Pouring your Long Island Ice Tea now.")
      end
    end
  end

end
