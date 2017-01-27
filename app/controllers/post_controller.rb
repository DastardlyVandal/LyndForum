class PostController < ApplicationController

    def create
        validate_user
        @stream = Stream.find_by_id(params[:stream_id])
        if @stream.locked?
            flash[:notice] = "Thread is locked."
            redirect_to board_streams_path + '/' + params[:stream_id]
        else
            if params[:post][:content].length <= 2000
                current_user.posts.create(board_id: params[:board_id], stream_id: params[:stream_id].to_i, content: params[:post][:content])
                stream = Stream.find_by_id(params[:stream_id]).update( updated_at: Time.now)
                redirect_to board_streams_path + '/' + params[:stream_id]
            else
                flash[:notice] = "Comment is too long."
                redirect_to(:back)
            end
        end
    end

    def new
        validate_user

        @user = current_user
        @post = Post.new
        @board = Board.find(params[:board_id].to_i)
        @stream = Stream.find(params[:stream_id].to_i)
    end

    def update
        validate_user
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
        validate_user
        unless current_user.role == 0
            flash[:notice] = "You are not permitted to perform this action."
            redirect_to :back
        end
        @post = Post.find_by_id(params[:id])
        @stream_id = @post.stream_id
        @board_id = Stream.find_by_id(@stream_id).board_id
    end

    def delete
        validate_user
        if current_user.role == 0 or current_user.role == 1
           Post.find_by_id(params[:post]).destroy
           redirect_to :back
        end
    end

    def ignore
        validate_user
        if current_user.role == 0 or current_user.role == 1
           Post.find_by_id(params[:post]).update(reported: false)
           redirect_to :back
        end
    end

    def report_post
        validate_user
        if current_user.role == 0 or current_user.role == 1
            @post = Post.find_by_id(params[:id])
            @post.update(rule: params[:post][:rule], reported: true)
           redirect_to('/board/' + @post.board_id.to_s + '/streams/' + @post.stream_id.to_s)
       else
           flash[:notice] = "You are not permitted to perform this action."
           redirect_to ('/board/')
       end


    end

    def report
        @post = Post.find_by_id(params[:id])
        @user = User.find_by_id(@post.user_id)
        @board_id = @post.board_id
        @stream_id = @post.stream_id
        @rules = Rule.where(board_id: @post.board_id).pluck(:rule)
    end


end
