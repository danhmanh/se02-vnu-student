require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) {FactoryBot.build :post}
  let(:user) {FactoryBot.create :user}

  it { should respond_to(:content) }

  it "valid with allowed length of content" do
    expect(post).to be_valid
  end

  it "is invalid with empty content" do
    post.content = ""
    expect(post).to be_invalid
  end

  it "is invalid with content too long" do
    post.content = "a" * 600
    expect(post).to be_invalid
  end


end
