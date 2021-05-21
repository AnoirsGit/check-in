require 'rails_helper'

RSpec.describe Grant, type: :model do
  it 'validates presence of owner' do
    grant = Grant.new(target: 1)
    expect(grant.valid?).to be_falsey
  end

  it 'validates presence of target' do
    grant = Grant.new(owner: 1)
    expect(grant.valid?).to be_falsey
  end

  it 'validates uniqueness of 2 compose fields' do
    another_grant = Grant.create(owner: 1, target: 2)
    grant = Grant.new(owner: 1, target: 2)
    expect(grant.valid?).to be_falsey
  end

  it 'saves grant with valid attributes' do
    grant = Grant.new(owner: 1, target: 2)
    expect(grant.valid?).to be_truthy
  end
end
