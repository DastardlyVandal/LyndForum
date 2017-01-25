class UsersController < ApplicationController

=begin
User Roles:
  0 => Admin
  1 => Mod
  2 => Normal User
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
                @thumbup = Vote.where(poster_id: @user.id, vote: 1).sum(:vote)
                @thumbdown = Vote.where(poster_id: @user.id, vote: -1).sum(:vote)
            else
                flash[:notice] = "User not found."
                redirect_to "/users/" + current_user.id.to_s
            end
        end
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
