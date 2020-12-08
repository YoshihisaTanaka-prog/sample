class HomesController < ApplicationController

    layout "homes"
  
    def index
    end
  
    def caution
      @level = params["level"]
    end
    
end
