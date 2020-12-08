class EditsController < ApplicationController

    before_action :authenticate_user!
    layout "edits"
  
    def index
        limit_normal 1
    end

    def authentication_update
        limit_strong
        # データ更新のためのフォーム送信はPOSTではなくPATCHであることに注意
        obj = User.find(params[:user_id])
        obj.level = params[:level]
        obj.save
        redirect_to "/edits/authentication"
    end
  
    def authentication
        limit_strong
        @msg = "Please type search word..."
        if request.post? then
        f = '%' + params["find"] + '%'
        @users = User.where "email like ?", f
        # @users = User.all
        end
    end

end
