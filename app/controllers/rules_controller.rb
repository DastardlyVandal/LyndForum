class RulesController < ApplicationController
    before_action :validate_admin, only: [:new, :create]

    def new
        @board = Board.find_by_id(params[:board_id])
    end

    def create
        rules = params[:rule]
        board_id = params[:board_id]
        rules.each do |r|
            unless r == ""
                Rule.create(board_id: board_id, rule: r)
            end
        end
        redirect_to('/board/' + board_id + '/rules/')
    end

    def index
        @board = Board.find_by_id(params[:board_id])
        @rules = Rule.where(board_id: @board.id)
    end
end
