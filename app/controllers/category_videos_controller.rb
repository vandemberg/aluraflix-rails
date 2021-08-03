class CategoryVideosController < ApplicationController
  def index
    category_id = params[:category_id]
    category = Category.find(category_id)

    render json: category.videos, status: :ok
  end
end
