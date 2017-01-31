class AnnouncementsController < ApplicationController
    before_action :validate_admin, only: [:create, :new]

    def create
        if params[:title].present? == false or params[:content].present? == false
            flash[:notice] = "Please fill out all fields."
            redirect_to(:back)
        end

        new_announcement = Announcement.create(title: params[:title], content: params[:content], user_id: current_user.id)

        redirect_to announcements_path
    end

    def new
        if validate_user

            unless validate_admin
                flash[:notice] = "Authorization Failed."
                redirect_to board_path
            end

            @announcement = Announcement.new
        end
    end

    def show
        if Announcement.find_by_id(params[:id]).present?
            @announcement = Announcement.find_by_id(params[:id])
            @user = User.find_by_id(@announcement.user_id)
        else
            flash[:notice] = "Announcement not found."
            redirect_to "/announcements/"
        end
    end

    def index
        @announcements = Announcement.all.reverse_order
    end

end
