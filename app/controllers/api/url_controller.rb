# frozen_string_literal: true

module Api
  class UrlController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      urls = Url.all
      render json: urls # Not using serializers
    end

    def show
      url = Url.find_by(short: params[:short])
      if url
        render json: url
      else
        render json: { message:  "Shortened URL not found. Try generating it again." }
      end
    end

    def create
      url = Url.new(url_params)
      if url.save
        render json: url
      else
        render json: { message: url.errors.full_messages.join(', ') }
      end
    end

    def destroy
      url = Url.find_by(short: params[:id])
      if url
        url.destroy
        render json: { url: url, message: "Successfully deleted" }
      else
        render json: { message:  "Shortened URL not found. Try generating it again." }
      end
    end

    private

    def url_params
      params.require(:url).permit(:original)
    end
  end
end
