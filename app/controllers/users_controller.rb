class UsersController < ApplicationController

    def show
        if User.find_by_id(params[:id]).present?
            @user = User.find_by_id(params[:id])
            @posts = @user.posts.each
            @votes = Vote.where(poster_id: @user.id)
            @thumbup = @votes.where(vote: 1).sum(:vote)
            @thumbdown = @votes.where(vote: -1).sum(:vote)
            @role = get_role(@user.id)
        else
            flash[:notice] = "User not found."
            redirect_to "/users/" + current_user.id.to_s
        end
    end

    def index
        if validate_user
            if params[:page].present?
                _page = params[:page]
            else
                _page = 1
            end

            @users = User.all
            @users = @users.paginate(page: _page, per_page: 12)
        end
    end

    def make_mod
        if validate_user
            if validate_admin
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

    def ban
        if validate_user
            if validate_admin
                user = User.find_by_id(params[:user])
                unless user.role == 0
                    ban_status = !user.banned
                    user.update(banned: ban_status)
                    flash[:notice] = "User banned status changed"
                end
                redirect_to :back
            end
        end
    end


    private
        #User Roles:
        #  0 => Admin
        #  1 => Mod
        #  2 => Normal User
        def get_role(uid)
            user = User.find_by_id(uid)
            role = user.role
            if user.banned
                return "Banned"
            elsif role == 0
                return "Admin"
            elsif role == 1
                return "Moderator"
            else
                return "User"
            end

        end
end
