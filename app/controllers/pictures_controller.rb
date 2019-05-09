class PicturesController < ApplicationController
  before_action :authenticate_user!
  def create
    @picture = Picture.new(image_params)
    if @picture.save
      respond_to do |format|
        format.json { render json: { url: @picture.image(:size400x300), picture_id: @picture.id } }
      end
    else
      flash[:danger].now = @picture.errors.to_s
    end
  end

  def destroy
    picture = Picture.find(params[:id])
    if picture.destroy
      respond_to do |format|
        format.json { render json: { status: :ok } }
      end
    else
      flash[:danger].now = picture.errors.to_s
    end
  end

  private

  def image_params
    params.require(:picture).permit(:image)
  end
end
