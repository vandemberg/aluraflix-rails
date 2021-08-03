class VideosController < ApplicationController
  before_action :authorize_request, except: [:free]
  before_action :set_video, only: [:show, :update, :destroy]

  # GET /videos
  def index
    @videos =
      if params[:search].present?
        Video.where("title like ?", "%#{params[:search]}%")
      else
        Video.all.offset(params[:page] || 1).limit(5)
      end

    render json: @videos
  end

  # GET /videos/1
  def show
    render json: @video
  end

  # POST /videos
  def create
    @video = Video.new(video_params)

    if @video.save
      render json: @video, status: :created, location: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /videos/1
  def update
    if @video.update(video_params)
      render json: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # DELETE /videos/1
  def destroy
    @video.destroy
  end

  def free
    @videos = Video.limit(5)

    render json: @videos
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def video_params
      params.require(:video).permit(:url, :description, :title, :category_id)
    end
end
