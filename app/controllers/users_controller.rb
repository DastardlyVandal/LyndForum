class UsersController < ApplicationController
    before_filter :validate_user

=begin
User Roles:
    Admin: Ann - 0
    General: Gerald - 1
    Small-Farm: Sally - 2
    Ag-Indus: Albert - 3
    un-assigned: Uncle - 4
=end

    def show
        unless params[:id].present?
            @user = current_user
        else
            if User.find_by_id(params[:id]).present?
                @user = User.find(params[:id])
                @posts = @user.posts.each
                @streams = Stream.all
                @started_streams = Stream.where(user_id: @user.id).length
            else
                flash[:notice] = "User not found."
                redirect_to "/users/" + current_user.id.to_s
            end
        end
    end

    def update
        @user = User.find_by_id(current_user.id)

        if params[:user][:role] == "Sally"
            @user.update(role: 2)
        elsif params[:user][:role] == "Albert"
            @user.update(role: 3)
        else
            @user.update(role: 1)
        end

        redirect_to(:root)
    end

    def new
        super
        byebug
    end

    def reports
        @user = current_user.id
    end

    private
        def get_occupation
            if @user.role == 0
                @commitment = "Admin"
            elsif @user.role == 1
                @commitment = "General"
            elsif @user.role == 2
                @commitment = "Small Farmer"
            elsif @user.role == 3
                @commitment = "Ag-Industrial Farmer"
            else
                @commitment = "Not Set"
            end
            return @commitment
        end
end
