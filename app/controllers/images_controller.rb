class ImagesController < ApplicationController
  def show
    if params[:gender] == "girl"
      gender = 1
    elsif params[:gender] == "boy"
      gender = 0
    else
      raise
    end
    length = Image.where("gender = #{gender}").count
    if length<2
     raise "Too few pictures."
    end
    ids = []
    Image.where("gender = #{gender}").each do |img|
      ids << img.id
    end
    random1 = ids.sample
    random2 = ids.sample
    while random2 == random1
      random2 = ids.sample
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

  def edit
    @image1 = Image.find params['img1']
    @image2 = Image.find params['img2']

    vote1 = @image1.vote
    vote1 += 1
    vote2 = @image2.vote
    vote2 += 1

    win1 = @image1.win
    win2 = @image2.win

    if params['selected'] == '1'
      win1 += 1
    elsif params['selected'] == '2'
      win2 += 1
    else
      raise "Error"
    end

    rate1 = win1.to_f/vote1.to_f
    rate2 = win2.to_f/vote2.to_f

    @image1.update_attributes vote: vote1, win: win1, rate: rate1
    @image2.update_attributes vote: vote2, win: win2, rate: rate2

    respond_to do |format|
      format.html { render :edit }
      format.json { render :partial => "edit.json" }
    end
  end

  private
  def image_params
    params.require(:image).permit(:img, :gender)
  end
end
