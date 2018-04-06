require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user, zip: 36143) }

  describe '.coordinates' do
    it 'returns coordinates separated with coma' do
      example = '40.7143528,-74.0059731'
      expect(helper.coordinates(user)).to eq(example)
    end
  end
  describe '.full_addr' do
    it 'returnes full address' do
      example = "36143, Ukraine, Dnipropetrovsk, Dnipro, 24 tytova"
      instance_variable_set(:@user, user)
      expect(helper.full_addr).to eq(example)
    end
  end
end
