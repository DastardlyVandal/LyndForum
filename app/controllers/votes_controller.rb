class VotesController < ApplicationController
    def create
        _post_id = params[:post_id]
        _user_id = current_user.id
        _vote = params[:vote]
        if _vote.to_i == 1 or _vote.to_i == -1
            if Vote.where(user_id: _user_id, post_id: _post_id).present? == false
                vote = Vote.create(user_id: _user_id, post_id: _post_id, vote: _vote)
            end
        end
    end

    def update

    end

    def index
        render plain: params.inspect
    end

end
