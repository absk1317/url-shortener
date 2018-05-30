# frozen_string_literal: true

class UrlController < ApplicationController

  def index
    @url = Url.new
    @urls = Url.all
  end

  def show
    url = Url.find_by(short: params[:short])
    if url
      redirect_to url.target_url
    else
      flash[:error] = "Shortened URL not found. Try generating it again."
      @url = Url.new # for the form on index page
      render :index
    end
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      message = "Your URL has been shortened as
                 <a href=/urls/#{@url.short} target='_blank'> http://urls/#{@url.short} </a>"
      flash[:success] = message
      redirect_to root_path
    else
      flash[:error] = @url.errors.full_messages.join('<br/>')
      render :index
    end
  end

  private

  def url_params
    params.require(:url).permit(:original)
  end
end
