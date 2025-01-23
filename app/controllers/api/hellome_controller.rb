require 'httparty'

module Api
  class HellomeController < ApplicationController
    def hello
      # Extract name from the JSON payload
      name = params[:name]
      return render json: { error: 'Name is required' }, status: :bad_request unless name

      # Call ChatGPT free API
      chatgpt_response = mock_fetch_chatgpt_response("Say 'hello from ChatGPT'")

      if chatgpt_response
        # Construct and return the final message
        final_message = "#{chatgpt_response}, #{name}"
        render json: { answer: final_message }, status: :ok
      else
        render json: { error: 'Failed to fetch response from ChatGPT' }, status: :service_unavailable
      end
    end

    private

    def mock_fetch_chatgpt_response(prompt)
        return 'Helloooooo'
    end

    def fetch_chatgpt_response(prompt)
      # Replace with your ChatGPT API endpoint and key if needed
      url = 'https://api.openai.com/v1/chat/completions'
      api_key = ENV['OPENAI_API_KEY']

      response = HTTParty.post(
        url,
        headers: {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{api_key}"
        },
        body: {
          model: "gpt-3.5-turbo", # Free ChatGPT API model
          messages: [{ role: "user", content: prompt }]
        }.to_json
      )

      # Parse and return the ChatGPT response
      if response.code == 200
        response.parsed_response['choices'][0]['message']['content'].strip
      else
        Rails.logger.error("ChatGPT API error: #{response.body}")
        nil
      end
    end
  end
end
