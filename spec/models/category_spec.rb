require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'validates presence of title' do
    category = Category.new(title: nil)
    expect(category.valid?).to be_falsey
  end

  it 'saves with valid attributes' do
    category = Category.new(title: 'sample')
    expect(category.valid?).to be_truthy
  end
end
