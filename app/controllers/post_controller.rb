class PostController < ApplicationController
    before_filter :validate_user #change to before_action

    def create
        if params[:post][:content].length <= 2000
            current_user.posts.create(stream_id: params[:stream_id].to_i, content: params[:post][:content])
            redirect_to board_streams_path + '/' + params[:stream_id]
        else
            flash[:notice] = "Comment is too long."
            redirect_to(:back)
        end
    end

    def new
        @user = current_user
        @post = Post.new
        @board = Board.find(params[:board_id].to_i)
        @stream = Stream.find(params[:stream_id].to_i)
    end

    def update
        unless current_user.role == 0
            flash[:notice] = "You are not permitted to perform this action."
            redirect_to(root)
        end

        post = Post.find_by_id(params[:id].to_i)
        post.update(content: params[:post][:content])


        board_id = Stream.find_by_id(post.stream_id).board_id

        redirect_to board_streams_path + '/' + post.stream_id.to_s
    end

    def edit
        unless current_user.role == 0
            flash[:notice] = "You are not permitted to perform this action."
            redirect_to(root)
        end
        @post = Post.find_by_id(params[:id])
    end
end
