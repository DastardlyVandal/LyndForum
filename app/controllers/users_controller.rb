class UsersController < ApplicationController

    def show
        byebug
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

    def index
        if params[:page].present?
            _page = params[:page]
        else
            _page = 1
        end

        @users = User.all
        @users = @users.paginate(page: _page, per_page: 12)
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
