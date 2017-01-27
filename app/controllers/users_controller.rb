class UsersController < ApplicationController

    def show
        if User.find_by_id(params[:id]).present?
            @user = User.find_by_id(params[:id])
            @posts = @user.posts.each
            @thumbup = @user.votes.where(poster_id: @user.id, vote: 1).sum(:vote)
            @thumbdown = @user.votes.where(poster_id: @user.id, vote: -1).sum(:vote)
            @role = get_role(@user.id)
        else
            flash[:notice] = "User not found."
            redirect_to "/users/" + current_user.id.to_s
        end
    end

    def make_mod
        if validate_user == true
            if validate_admin == true
                user = User.find_by_id(params[:user])
                if user.role != 0
                    user.update(role: params[:role])
                    flash[:notice] = "User Moderation status changed"
                    redirect_to :back
                end
            else
                flash[:notice] = "Operation not permitted"
                redirect_to('/')
            end
        end
    end

    private
        #User Roles:
        #  0 => Admin
        #  1 => Mod
        #  2 => Normal User
        def get_role(uid)
            role = User.find_by_id(uid).role
            if role == 0
                return "Admin"
            elsif role == 1
                return "Moderator"
            else
                return "User"
            end

        end
end
