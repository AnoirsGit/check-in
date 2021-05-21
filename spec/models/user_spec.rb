require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence of email' do
    user = User.new

    expect(user.valid?).to be_falsey
  end
end
