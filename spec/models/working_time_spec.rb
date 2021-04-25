require 'rails_helper'

RSpec.describe WorkingTime, type: :model do
  it 'validates presence of user' do
    working_time = WorkingTime.new(started_at: DateTime.now - 1.hour, ended_at: DateTime.now)
    expect(working_time.valid?).to be_falsey
  end

  it 'validates presence of started_time' do
    working_time = WorkingTime.new(user_id: 1, ended_at: DateTime.now)
    expect(working_time.valid?).to be_falsey
  end

  it 'validates presence of ended_time' do
    working_time = WorkingTime.new(started_at: DateTime.now - 1.hour, user_id: 1)
    expect(working_time.valid?).to be_falsey
  end

  it 'saves with valid attributes' do
    category = Category.create(title: 'abc')
    
    user = User.create(email: 'a@a.a',
                       password: '123456',
                       password_confirmation: '123456')

    working_time = WorkingTime.new(started_at: DateTime.now - 1.hour,
                                   ended_at: DateTime.now,
                                   user_id: user.id,
                                   category_id: category.id)
    expect(working_time.valid?).to be_truthy
  end
end
