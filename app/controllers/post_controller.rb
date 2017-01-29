class PostController < ApplicationController

    def create
        if validate_user
            @stream = Stream.find_by_id(params[:stream_id])
            if @stream.locked?
                flash[:notice] = "Thread is locked."
                redirect_to board_streams_path + '/' + params[:stream_id]
            else
                if params[:post][:content].length <= 2000
                    current_user.posts.create(board_id: params[:board_id], stream_id: params[:stream_id], content: params[:post][:content])
                    stream = Stream.find_by_id(params[:stream_id]).update( updated_at: Time.now)
                    redirect_to board_streams_path + '/' + params[:stream_id]
                else
                    flash[:notice] = "Comment is too long."
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
            @stream = Stream.find_by_id(params[:stream_id])
        end
    end

    def update
        if validate_user
            unless validate_admin
                flash[:notice] = "You are not permitted to perform this action."
                redirect_to(root)
            end

            post = Post.find_by_id(params[:id].to_i)
            post.update(content: params[:post][:content])


            board_id = Stream.find_by_id(post.stream_id).board_id

            redirect_to board_streams_path + '/' + post.stream_id.to_s
        end
    end

    def edit
        if validate_user
            unless validate_admin
                flash[:notice] = "You are not permitted to perform this action."
                redirect_to :back
            end
            @post = Post.find_by_id(params[:id])
            @stream_id = @post.stream_id
            @board_id = Stream.find_by_id(@stream_id).board_id
        end
    end

    def delete
        if validate_user
            if validate_mod
               Post.find_by_id(params[:post]).destroy
               redirect_to :back
            end
        end
    end

    def ignore
        if validate_user
            if validate_mod
               Post.find_by_id(params[:post]).update(reported: false)
               redirect_to :back
            end
        end
    end

    def report_post
        if validate_user
            if validate_mod
                @post = Post.find_by_id(params[:id])
                @post.update(rule: params[:post][:rule], reported: true)
               redirect_to('/board/' + @post.board_id.to_s + '/streams/' + @post.stream_id.to_s)
           else
               flash[:notice] = "You are not permitted to perform this action."
               redirect_to ('/board/')
           end
       end


    end

    def report
        if validate_user
            @post = Post.find_by_id(params[:id])
            @user = User.find_by_id(@post.user_id)
            @board_id = @post.board_id
            @stream_id = @post.stream_id
            @rules = Rule.where(board_id: @post.board_id).pluck(:rule)
        end
    end


end
