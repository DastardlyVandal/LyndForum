class RulesController < ApplicationController
    def new
        if validate_user == true
            if validate_admin == true
                @board = Board.find_by_id(params[:board_id])
            else
                flash[:notice] = "You are not authorized to do that."
                redirect_to('/board/')
            end
        end
    end

    def create
        if validate_user == true
            if validate_admin == true
                if params[:reason] == ''
                    flash[:notice] = "Rule can't be empty."
                    redirect_to(:back)
                else
                    new_rule = Rule.create(board_id: params[:board_id], rule: params[:reason])
                    redirect_to('/board/')
                end
            else
                flash[:notice] = "You are not authorized to do that."
                redirect_to('/board/')
            end
        end
    end

    def index
        @board = Board.find_by_id(params[:board_id])
        @rules = Rule.where(board_id: @board.id)
    end
end
