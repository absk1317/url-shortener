# frozen_string_literal: true

class Url < ApplicationRecord
  validates :original, presence: true
  validate :sanitized_pattern

  validates_format_of :original,
                      with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/

  before_create :generate_short

  def generate_short
    chars = ['0'..'9', 'A'..'Z', 'a'..'z'].map(&:to_a).flatten
    self.short = SecureRandom.hex(6) until Url.find_by(short: short).nil?
  end

  def new?
    Url.find_by(sanitized: sanitized).nil?
  end

  def sanitize
    sanitized = original.strip.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
    sanitized.slice!(-1) if sanitized[-1] == '/'
    self.sanitized = "http://#{sanitized}"
  end

  def sanitized_pattern
    existing = Url.find_by(sanitized: sanitized)
    return unless existing
    errors.add(:original, "Shortened URL already present. Do you want to visit #{existing.short} ?")
  end
end
