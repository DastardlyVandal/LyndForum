class BoardController < ApplicationController
    before_action :validate_admin, only: [:create, :new, :lock, :delete]
    before_action :validate_mod, only: [:moderation]

  def create
      new_board = Board.create(name: params[:name])
      redirect_to '/board/' + new_board.id.to_s + '/streams/'
  end


  def new

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

  def lock
      @board = Board.find_by_id(params[:board])
      @lock = !@board.locked
      @board.update(locked: @lock)
      redirect_to :back
  end

  def delete
      @board = Board.find_by_id(params[:board])
      @board.destroy
      redirect_to :back
  end

end
