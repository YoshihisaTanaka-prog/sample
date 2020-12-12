class EditsController < ApplicationController

    before_action :authenticate_user!
    layout "edits"
  
    def index
        limit_normal 1
    end

    def caution
        @level = params["level"]
    end


    # 編集系

    def edit
        limit_normal 2
        @id = params["id"]
        @route = Route.find(@id)
    end

    def edit_update
        limit_normal 2

        @id = params["id"]
        @title = params["title"]
        @before_id = params["before_id"]
        obj = Route.find(@id)
        obj.table_name = params["table_name"]
        obj.next_title_name = params["next_title_name"]
        obj.save

        redirect_to controller: :edits, action: :show, params: {"title": @title , "id": @before_id}
    end


    # 追加系

    def add_route
        limit_normal 2

        @route = Route.new
    end

    def create_route
        limit_normal 2

        if request.post? then

            # 次のIDを取得
            ids = params["ids"].split("-")
            next_id = params["before_id"] + "-" + ((ids.last.to_i) + 1).to_s

            obj = Route.new({ before_id: params["before_id"], table_name: params["table_name"], next_title_name: params["next_title_name"], after_id: next_id })
            obj.save
        end
        @title = params["title"]
        @before_id = params["before_id"]
        redirect_to controller: :edits, action: :show, params: {"title": @title , "id": @before_id}
    end

    def show
        limit_normal 2
        @title = params["title"]
        @before_id = params["id"]
        @tables = Route.where(before_id: @before_id)

        @ids = "0"
        @tables.each do |t|
            @ids = t.after_id
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
