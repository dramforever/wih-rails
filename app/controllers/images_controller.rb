class ImagesController < ApplicationController
  def show
    length = Image.count
    if length<2
      raise "Too few pictures."
    end
    random1 = rand 1..length
    random2 = rand 1..length
    while random2 == random1
      random2 = rand 1..length
    end
    @image1 = Image.find random1
    @image2 = Image.find random2
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)
    @image.save
  end

  private
  def image_params
    params.require(:image).permit(:img)
  end
end
