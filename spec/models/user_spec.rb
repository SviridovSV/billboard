require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments) }
  end

  describe 'Validations' do
    [:login, :first_name, :last_name, :birthday, :address, :city,
     :state, :country, :zip, :email].each do |field|
      it { should validate_presence_of(field) }
    end

    it { should validate_numericality_of(:zip) }
    it { should validate_uniqueness_of(:login).case_insensitive }
  end

  describe 'Geocode' do
    let(:user) { build(:user) }

    it 'set longitude and latitude when save object' do
      expect(user.longitude).to eq(nil)
      expect(user.latitude).to eq(nil)
      user.save
      expect(user.longitude).to eq(-74.0059731)
      expect(user.latitude).to eq(40.7143528)
    end
  end

  describe 'Role' do
    let(:user) { create(:user) }

    context '.admin?' do
      it 'return false if not admin' do
        expect(user.admin?).to be_falsey
      end
      it 'return true if admin' do
        user.update_attribute(:role, 'admin')
        expect(user.admin?).to be_truthy
      end
    end

    context '.moderator?' do
      it 'return false if not moderator' do
        expect(user.moderator?).to be_falsey
      end
      it 'return true if moderator' do
        user.update_attribute(:role, 'moderator')
        expect(user.moderator?).to be_truthy
      end
    end
  end

  describe 'Full attributes' do
    let(:user) { create(:user, first_name: 'John', last_name: 'Doe') }

    context '.full_name' do
      it 'return first name and last name' do
        expect(user.full_name).to eq('John Doe')
      end
    end

    context '.full_address' do
      it 'return address, city, state and country in one string' do
        expect(user.full_address).to eq('24 tytova, dnipro, dnipropetrovsk, ukraine')
      end
    end
  end
end
