require 'sinatra'

# HelloApp
class HelloApp < Sinatra::Base
  get '/' do
    <<-HTML
        <!DOCTYPE html>
        <html>
            <body>Hello World!</body>
        </html>
    HTML
  end
end
