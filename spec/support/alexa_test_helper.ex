defmodule Alexa.TestHelper do
  alias Alexa.Request

  @app_id "test-app-id"

  def intent_request(intent_name, slot_values \\ nil, attributes \\ nil) do
    Request.intent_request(@app_id, intent_name, nil, slot_values, attributes)
  end
end
