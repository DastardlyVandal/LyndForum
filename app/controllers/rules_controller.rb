class RulesController < ApplicationController
    def new
        if validate_user
            if validate_admin
                @board = Board.find_by_id(params[:board_id])
            else
                flash[:notice] = "You are not authorized to do that."
                redirect_to('/board/')
            end
        end
    end

    def create
        if validate_user
            if validate_admin
                rules = params[:rule]
                board_id = params[:board_id]
                rules.each do |r|
                    unless r == ""
                        Rule.create(board_id: board_id, rule: r)
                    end
                end
                redirect_to('/board/' + board_id + '/rules/')
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
