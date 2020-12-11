class EditsController < ApplicationController

    before_action :authenticate_user!
    layout "edits"
  
    def index
        limit_normal 1
    end

    def caution
        @level = params["level"]
    end

    def edit
        limit_normal 2
        @@id = params["id"]
        route = Route.find(@@id)
    end

    def edit_update
        limit_normal 2

        obj = Route.find(@@id)
        obj.table_name = params["table_name"]
        obj.next_title_name = params["next_title_name"]
        obj.save

        redirect_to  controller: :edits, action: :show, params: {"title": @@title , "id": @@before_id}
    end

    def add
        limit_normal 2
    end

    def show
        limit_normal 2
        @@title = params["title"]
        @@before_id = params["id"]
        @tables = Route.where(before_id: @@before_id)

        @@ids = []
        @tables.each do |t|
            @@ids.push(t.after_id)
        end
    end


    # 権限を変更する

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
    
        @q = User.ransack(params[:q])
        @users = @q.result(distinct: true)

    end

end
