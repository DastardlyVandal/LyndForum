class BoardController < ApplicationController

  def create
      validate_user
      unless current_user.role == 0
          flash[:notice] = "You are not authorized to create new boards."
          redirect_to(:back)
      end

      new_board = Board.create(name: params[:name])
      byebug
      redirect_to '/board/' + new_board.id.to_s + '/streams/'
  end


  def new
      validate_user
      unless current_user.role == 0
          flash[:notice] = "Authorization Failed."
          redirect_to board_path
      end

  end


  def index
      @boards = Board.all
      @announcements = Announcement.all.reverse_order
  end

end
