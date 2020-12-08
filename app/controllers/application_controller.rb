class ApplicationController < ActionController::Base

    user_score_title_list = ["score1","score2"]
    route_score_title_list = ["score1","score2"]

    def after_sign_out_path_for(resource)
        root_path
    end


    # ページに入れるユーザを制限する
  
    def limit_normal num
        if current_user.level < num then
            if current_user.level == 0 then
                redirect_to controller: :homes, action: :caution, params: {"level": num.to_s + "以上のユーザレベル"}
            else
                redirect_to controller: :edits, action: :caution, params: {"level": num.to_s + "以上のユーザレベル"}
            end
        end
    end

    def limit_strong
        if current_user.email != "nakanaka.tanaka4413@gmail.com" then
            if current_user.level == 0 then
                redirect_to controller: :homes, action: :caution, params: {"level": "最強のユーザレベル"}
            else
                redirect_to controller: :edits, action: :caution, params: {"level": "最強のユーザレベル"}
            end
        end
    end


    # データ点数（を計算するパラメータ）の取得
    def get_hash_main data title_list
        score_list = data.split(",")
        score_num_hash = {}
        num = 0
        title_list.each do |t|
            if num < score_num_list.length then
                score_num_hash[t] = score_num_list.to_i
            else
                score_num_hash[t] = 0            
            end
        end
        return score_num_hash
    end

    def get_user_score_hash num
        user = User.find(num)
        return get_hash_main user.score title_array
    end

    def get_route_score_hash num
        route = Route.find(num)
        return get_hash_main route.score title_array
    end


    # データ点数（を計算するパラメータ）の保存
    def save_user_score_hash (num,hash)
        user = User.find(num)
        user.score = save_hash_main(hash,user_score_title_list)
        user.save
    end

    def save_route_score_hash (num,hash)
        route = Route.find(num)
        route.score = save_hash_main(hash,route_score_title_list)
        route.save
    end

    def save_hash_main (num_hash,title_list)
        save_data = ""
        title_list.each do |t|
            save_data += (num_hash[t]).to_text + ","
        end
        return save_data
    end

end
