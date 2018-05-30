require 'rails_helper'

RSpec.describe Url, type: :model do

  describe 'has validations intact' do
    it { is_expected.to validate_presence_of(:original)
                                            .with_message(/url must be present/) }
    it { is_expected.to validate_uniqueness_of(:original)
                                            .with_message(/has already been shortened as/) }
  end
end
