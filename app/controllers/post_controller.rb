class PostController < ApplicationController
    before_action :validate_admin, only: [:update, :edit]
    before_action :validate_mod, only: [:delete, :ignore]
    before_action :validate_user, only: [:create, :new, :report, :report_post]

    def create
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

    def new
        @user = current_user
        @post = Post.new
        @board = Board.find_by_id(params[:board_id])
        @stream = Stream.find_by_id(params[:stream_id])
    end

    def update
        post = Post.find_by_id(params[:id].to_i)
        post.update(content: params[:post][:content])

        redirect_to '/board/'+ post.board_id.to_s + '/streams/' + post.stream_id.to_s
    end

    def edit
        @post = Post.find_by_id(params[:id])
        @stream_id = @post.stream_id
        @board_id = Stream.find_by_id(@stream_id).board_id
    end

    def destroy
       post = Post.find_by_id(params[:id].to_i)
       # Prevent Admin and Moderator posts from getting deleted
       # However, if the mod or admin posted it themselves, it can still be Removed
       # Admins can do whatever they want
       if current_user.role = 0 or User.find_by_id(post.user_id).role > 1 or post.user_id == current_user.id
           post.destroy
           flash[:notice] = "Post Removed."
           redirect_to :back
       else
           flash[:notice] = "Post couldn't be removed. Was it made by a Mod or an Admin?"
           redirect_to :back
       end
    end

    def ignore
       Post.find_by_id(params[:post_id].to_i).update(reported: false)
       redirect_to :back
    end

    def report_post
        @post = Post.find_by_id(params[:id])
        @post.update(rule: params[:post][:rule], reported: true)
       redirect_to('/board/' + @post.board_id.to_s + '/streams/' + @post.stream_id.to_s)
   end

    def report
        @post = Post.find_by_id(params[:id])
        @user = User.find_by_id(@post.user_id)
        @board_id = @post.board_id
        @stream_id = @post.stream_id
        @rules = Rule.where(board_id: @post.board_id).pluck(:rule)
    end


end
