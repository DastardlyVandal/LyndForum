class StreamsController < ApplicationController

  def create
      validate_user

      unless params[:title].match(" ").present?
          flash[:notice] = "Please write your titles as a sentence."
          redirect_to(:back)
      else
          if params[:title].length <= 100
              if params[:content].length <= 10000
                  content = params[:content]
                  new_stream = Stream.create(board_id: params[:board_id], user_id: current_user.id, title: params[:title])
                  current_user.posts.create(stream_id: new_stream.id, content: content)

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
      validate_user

      @user = current_user
      @post = Post.new
      @board = Board.find(params[:board_id].to_i)
      @board_name = Board.find(params[:board_id].to_i).name
      @stream = Stream.new
  end

  def index
    if Board.find_by_id(params[:board_id]).present?
        if params[:page].present?
            _page = params[:page]
        else
            _page = 1
        end

#        @streams = Stream.where(board_id: params[:board_id]).each.sort_by{|stream| stream.updated_at}.reverse
        @streams = Stream.where(board_id: params[:board_id])
        @streams = @streams.order(updated_at: :desc)
        @streams = @streams.paginate(page: _page, per_page: 7)
        @board_name = Board.find(params[:board_id].to_i).name
        @board_id = params[:board_id]
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
        @posts = @posts.paginate(page: _page, per_page: 10) #Post.where(stream_id: params[:id]).each
        @stream_title = Stream.find(params[:id].to_i).title
        @board_name = Board.find(params[:board_id].to_i).name
        @board_id = params[:board_id]
        @stream_id = params[:id]
        @post = Post.new
        @users = User.all
        @streams = Stream.all
        @votes = Vote.all
    else
        flash[:notice] = "Thread not found."
        redirect_to "/board/"
    end
  end

end
