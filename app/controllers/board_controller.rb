class BoardController < ApplicationController

  def create
      validate_user
      unless current_user.role == 0
          flash[:notice] = "You are not authorized to create new boards."
          redirect_to(:back)
      end

      new_board = Board.create(name: params[:name])
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
      @hot_threads = []
      @boards.each do |b|
          if b.streams.sort_by{ |s| s.updated_at }.reverse.first.present?
              @hot_threads.push(b.streams.sort_by{ |s| s.updated_at }.reverse.first)
          end
      end

      @announcements = Announcement.all.reverse_order
  end

  def moderation
      validate_user
      unless current_user.role == 0 or current_user.role == 1
          flash[:notice] = "You are not authorized to perform this action"
          redirect_to('/board/')
      end

      if params[:page].present?
          _page = params[:page]
      else
          _page = 1
      end
      @posts = Post.where(board_id: params[:board_id], reported: true)
      @posts = @posts.paginate(page: _page, per_page: 10)
      @streams = Stream.all
      @users = User.all
      @board_name = Board.find_by_id(params[:board_id]).name


  end

end
