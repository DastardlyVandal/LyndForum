class StreamsController < ApplicationController

  def create
      if validate_user

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
  end

  def new
      if validate_user

          @user = current_user
          @post = Post.new
          @board = Board.find_by_id(params[:board_id])
          @stream = Stream.new
      end
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

  def delete
      if validate_user
          if validate_mod
             @stream = Stream.find_by_id(params[:stream])
             @stream.destroy
             redirect_to :back
          end
      end
  end

  def sticky
      if validate_user
          if validate_mod
              @stream = Stream.find_by_id(params[:stream])
              @sticky = !@stream.is_stickied
              @stream.update(is_stickied: @sticky)
              redirect_to :back
          end
      end
  end

  def lock
      if validate_user
          if validate_mod
              @stream = Stream.find_by_id(params[:stream])
              @lock = !@stream.locked
              @stream.update(locked: @lock)
              redirect_to :back
          end
      end
  end

end
