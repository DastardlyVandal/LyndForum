class StreamsController < ApplicationController
  before_action :validate_user, only: [:create, :new]
  before_action :validate_mod, only: [:sticky, :lock, :delete]

  def create
      unless params[:title].match(" ").present?
          flash[:notice] = "Please write your titles as a sentence."
          redirect_to(:back)
      else
          if params[:title].length <= 100
              if params[:content].length <= 10000
                  content = params[:content]
                  new_stream = Stream.create(board_id: params[:board_id], user_id: current_user.id, title: params[:title])
                  current_user.posts.create(board_id: params[:board_id], stream_id: new_stream.id, content: content)

                  redirect_to board_streams_path + '/' + new_stream.id.to_s
              else
                  flash[:notice] = "Comment is too long."
                  redirect_to(:back)
              end

          else
              flash[:notice] = "Title is too long."
              redirect_to(:back)
          end
      end
  end

  def new
      @user = current_user
      @post = Post.new
      @board = Board.find_by_id(params[:board_id])
      @stream = Stream.new
  end

  def index
    if Board.find_by_id(params[:board_id]).present?
        if params[:page].present?
            _page = params[:page]
        else
            _page = 1
        end

        @streams = Stream.where(board_id: params[:board_id])
        @streams = @streams.order(is_stickied: :desc, updated_at: :desc)
        @streams = @streams.paginate(page: _page, per_page: 7)

        @board = Board.find_by_id(params[:board_id])
        @users = User.all
    else
        flash[:notice] = "Board not found."
        redirect_to "/board/"
    end
  end

  def show
      if params[:page].present?
          _page = params[:page]
      else
          _page = 1
      end

      if Stream.find_by_id(params[:id]).present?
        @posts = Post.where(stream_id: params[:id])
        @posts = @posts.paginate(page: _page, per_page: 10)
        @stream = Stream.find_by_id(params[:id])
        @board = Board.find_by_id(params[:board_id])
        @users = User.all
        @votes = Vote.all
    else
        flash[:notice] = "Thread not found."
        redirect_to "/board/"
    end
  end

  def destroy
     stream = Stream.find_by_id(params[:id])
     # Prevent Admin and Moderator streams from getting deleted
     # However, if the mod or admin posted it themselves, it can still be Removed
     # Admins can do whatever they want
     if current_user.role == 0 or User.find_by_id(stream.user_id).role > 1 or stream.user_id == current_user.id
             stream.destroy
             flash[:notice] = "Thread Removed"
             redirect_to('/board/')
     else
         flash[:notice] = "Thread couldn't be removed. Was it posted by an Admin or another Moderator?"
         redirect_to :back
     end
  end

  def sticky
      stream = Stream.find_by_id(params[:stream_id])
      sticky = !stream.is_stickied
      stream.update(is_stickied: sticky)
      redirect_to :back
  end

  def lock
      stream = Stream.find_by_id(params[:stream_id])
      lock = !stream.locked
      stream.update(locked: lock)
      redirect_to :back
  end

end
