class LinesOutputController < ApplicationController
    require 'line/bot'
    protect_from_forgery :except => [:callback]

    def client
        @client ||= Line::Bot::Client.new { |config|
        #   config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        #   config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
        config.channel_secret = "ed5e5869c6e4a3b6ea06f311b55d48af"
        config.channel_token = "DOfoCEorKaruAhyKhQXAgHkaz3u9Jxnky7FXoZNpIlgwpDHnZaUaIwJkRaw15P8aVX206lI4SJVfn1UByAkFNjdG/QNNrnFYcSIrE53QmQtNDZw4gTRIHXF7lECjcN7QET0hEIsG8Ikfk6j+rYipUAdB04t89/1O/w1cDnyilFU="
        }
    end

    def callback
        body = request.body.read

        signature = request.env['HTTP_X_LINE_SIGNATURE']

        unless client.validate_signature(body, signature)
            head :bad_request
        end
    
        events = client.parse_events_from(body)
    
        events.each { |event|
          case event
          when Line::Bot::Event::Message
            case event.type
            when Line::Bot::Event::MessageType::Text
              message = {
                type: 'text',
                text: event.message['text']
              }
            end
          end
        }
    
        head :ok
    end
end