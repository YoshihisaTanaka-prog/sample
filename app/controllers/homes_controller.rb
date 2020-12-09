class HomesController < ApplicationController

    before_action :authenticate_user!, only: :caution

    layout "homes"
  
    def index
    end
  
    def caution
      @level = params["level"]
    end
    
end
