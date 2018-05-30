# frozen_string_literal: true

class Url < ApplicationRecord

  # validate presence of url to be encoded and give the link of existing incase it fails
  validates :original,
            presence: { message: 'url must be present' },
            uniqueness: {
              message: Proc.new do |object|
                existing = find_by(original: object.original)
                existing_url = "/urls/#{existing.short}"
                "#{object.original} as already been shortened as
                 <a href=#{existing_url} target='_blank'>#{existing.short}</a>"
              end
            }

  # validate the format of url
  validates_format_of :original,
                      with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/

  validates :sanitized, presence: true, on: :create

  before_validation :sanitize, :generate_short

  def target_url
    # append http before original incase not already there
    original=~/^https?:\/\// ? original : "http://#{original}"
  end

  private

  def generate_short
    # encode the url
    self.short = Base64.strict_encode64(sanitized)
  end

  def sanitize
    #sanitize the url for same results with www and http or https
    sanitized = original.strip.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
    sanitized.slice!(-1) if sanitized[-1] == '/'
    self.sanitized = "http://#{sanitized}"
  end

end
