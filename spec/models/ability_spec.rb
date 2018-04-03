require 'rails_helper'

RSpec.describe Ability, type: :model do
  let(:user) { build(:user) }
  let(:signed_user) { create(:user) }
  let(:moderator) { create(:user, role: 'moderator') }
  let(:admin) { create(:user, role: 'admin') }

  context 'when user is unsigned' do
    subject(:ability) { Ability.new(user) }

    it { should be_able_to(:read, Post) }
    it { should be_able_to(:read, Comment) }
    it { should be_able_to(:read, User) }
    it { should_not be_able_to(:create, Post.new(user_id: signed_user.id)) }
    it { should_not be_able_to(:create, Comment.new(user_id: signed_user.id)) }
  end

  context 'when user is signed' do
    subject(:ability) { Ability.new(signed_user) }

    it { should be_able_to(:create, Post.new(user_id: signed_user.id)) }
    it { should be_able_to(:create, Comment.new(user_id: signed_user.id)) }
    it { should_not be_able_to(:destroy, Post.new(user_id: signed_user.id + 1)) }
    it { should_not be_able_to(:destroy, Comment.new(user_id: signed_user.id + 1)) }
    it { should_not be_able_to(:update, User.new(role: 'moderator')) }
  end

  context 'when user is moderator' do
    subject(:ability) { Ability.new(moderator) }

    it { should be_able_to(:destroy, Post.new(user_id: moderator.id + 1)) }
    it { should be_able_to(:destroy, Comment.new(user_id: moderator.id + 1)) }
    it { should_not be_able_to(:update, User.new(role: 'moderator')) }
  end

  context "when user is admin" do
    subject(:ability) { Ability.new(admin) }

    it { should be_able_to(:manage, :all) }
  end
end