# frozen_string_literal: true

module Api::V1
  class WishListsController < ApplicationController
    skip_before_action :set_index, only: %i[index]
    skip_before_action :set_associated_items, only: %i[items]
    before_action :authenticate_user!
    before_action :set_wish_list, only: %i[show update destroy items]

    def index
      @wish_lists = current_user.wish_lists.paginate(page, length)
      @meta  = {
        page: page,
        length: length,
        total: current_user.wish_lists.count,
        total_pages: current_user.wish_lists.total_pages(length)
      }
      render json: @wish_lists, include: %i[items], meta: @meta
    end

    def show
      render json: @wish_list, include: %i[items]
    end

    def create
      @wish_list = WishList.new(wish_list_params)

      if @wish_list.save
        render json: @wish_list, include: %i[items], status: :created
      else
        render json: @wish_list.errors, status: :unprocessable_entity
      end
    end

    def update
      if @wish_list.update(wish_list_params)
        render json: @wish_list, include: %i[items]
      else
        render json: @wish_list.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @wish_list.destroy
    end

    def items
      @items  = @wish_list.items.paginate(page, length)
      @meta   = {
        page: page,
        length: length,
        total: @wish_list.items.count,
        total_pages: @wish_list.items.total_pages(length)
      }

      render json: @items, meta: @meta
    end

    def lite_items
      @items = current_user.wish_lists.joins(:items).select('items.id')

      render json: @items
    end

    private
      def set_wish_list
        id = params[:id] || params[:wish_list_id]
        @wish_list = WishList.find(id)
      end

      def wish_list_params
        params.require(:wish_list).permit(:name, items_ids: [], remove_items_ids: [])
      end
  end
end
