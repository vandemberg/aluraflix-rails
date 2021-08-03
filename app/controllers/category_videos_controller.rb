class CategoryVideosController < ApplicationController
  before_action :authorize_request

  def index
    category_id = params[:category_id]
    category = Category.find(category_id)

    render json: category.videos, status: :ok
  end
end
