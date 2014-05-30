# coding: utf-8
class ImagesController < ApplicationController
  
  ##
  # 显示随机图片
  #
  # 参数: gender: 性别
  def show
    if params[:gender] == "girl"
      gender = 1
    elsif params[:gender] == "boy"
      gender = 0
    else
      raise
    end
    imgs = Image.where("gender = #{gender} AND has_inspect = ?", true).all
    length = imgs.count
    if length<2
     raise "Too few pictures."
    end

    random1 = imgs.sample
    random2 = imgs.sample

    while random2 == random1
      random2 = imgs.sample
    end
    @image1 = Image.find random1
    @image2 = Image.find random2
  end

  ##
  # 上传图片界面
  def new
    @image = Image.new
    rand1 = rand 1..20
    rand2 = rand 1..20
    if rand(1..2) == 1
      question =  "#{  rand1 } + #{ rand2 } = ?"
      answer = rand1 + rand2
    else
      question =  "#{  rand1 } - #{ rand2 } = ?"
      answer = rand1 - rand2
    end

    @details = { question: question, answer: answer }
  end

  ##
  # 接收上传的图片
  #
  # 参数：
  # - user_answer：填写的验证问题答案
  # - answer：正确的验证问题答案
  # - image[gender]：性别
  # - image[img]：上传的图片
  def create
    user_answer = params[:user_answer]
    answer = params[:answer]
    if user_answer.to_i == answer.to_i
      @image = Image.new(image_params)
      @image.save
    else
      flash[:error] = "错误的验证回答！"
      redirect_to upload_path
    end
  end

  ##
  # 投票
  # 
  # 参数：
  # - img1：第一张图片的id
  # - img2：第二张图片的id
  # - selected：选择第一张还是第二张
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

  ## 
  # 删除一个图片
  #
  # 参数：id：要删除的图片id
  def destroy
    Image.find(params[:id]).destroy
    redirect_to inspect_images_path
  end

  ##
  # 审核图片界面
  # 
  def inspect
    @inspect_images = Image.where(has_inspect: false).all
  end

  ##
  # 审核通过一个图片
  #
  # 参数： id：要通过的图片
  def examine
     Image.find(params[:id]).update! has_inspect: true
     redirect_to inspect_images_path
  end

  ##
  # 显示投票最多的10张图片
  #
  # 参数：gender：性别
  def top
    if params[:gender] == "girl"
      gender = 1
    elsif params[:gender] == "boy"
      gender = 0
    else
      raise
    end
    @images = Image.where("gender = ? AND has_inspect = ?",gender,true).order("rate DESC").limit(10)
  end

  private
  
  ##
  # 过滤参数
  def image_params
    params.require(:image).permit(:img, :gender)
  end
end
