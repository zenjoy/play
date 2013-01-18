module Play
  class Api < Sinatra::Base
    
    get '/' do
      "Hello world!"
    end      
    
  end
end