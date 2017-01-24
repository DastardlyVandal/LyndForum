class BoardController < ApplicationController
  before_filter :validate_user

  def create
      unless current_user.role == 0
          flash[:notice] = "You are not authorized to create new boards."
          redirect_to(:back)
      end

      new_board = Board.create(name: params[:name])
      redirect_to board_path + '/' + new_board.id.to_s + '/streams/'
  end


  def new
      unless current_user.role == 0
          flash[:notice] = "Authorization Failed."
          redirect_to board_path
      end

  end


  def show
      @boards = Board.all
      @announcements = Announcement.all.reverse_order
  end

end
