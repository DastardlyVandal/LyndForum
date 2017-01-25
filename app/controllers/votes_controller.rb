class VotesController < ApplicationController
    def create
        validate_user

        _post_id = params[:post_id]
        _user_id = current_user.id
        _poster_id = Post.find_by_id(_post_id).user_id
        _vote = params[:vote].to_i

        if Post.find_by_id(_post_id).user.id == current_user.id
            flash[:notice] = "You can't vote on your own posts!"
            redirect_to :back
        else
            if _vote.to_i == 1 or _vote.to_i == -1
                if Vote.where(user_id: _user_id, post_id: _post_id).present? == false
                    vote = Vote.create(user_id: _user_id, post_id: _post_id, poster_id: _poster_id, vote: _vote)
                    redirect_to :back
                end
            end
        end
    end

    def update
        validate_user

    end
end
