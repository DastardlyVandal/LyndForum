class BoardController < ApplicationController

  def create
      if validate_user == true
          unless validate_admin == true
              flash[:notice] = "You are not authorized to create new boards."
              redirect_to(:back)
          end

          new_board = Board.create(name: params[:name])
          redirect_to '/board/' + new_board.id.to_s + '/streams/'
      end
  end


  def new
      if validate_user == true
          unless validate_admin == true
              flash[:notice] = "Authorization Failed."
              redirect_to board_path
          end
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
      if validate_user == true
          if validate_mod == false
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

  def lock
      if validate_user == true
          if validate_admin == true
              @board = Board.find_by_id(params[:board])
              @lock = !@board.locked
              @board.update(locked: @lock)
              redirect_to :back
          end
      end
  end

  def delete
      if validate_user == true
          if validate_admin == true
              @board = Board.find_by_id(params[:board])
              @board.destroy
              redirect_to :back
          end
      end
  end

end
