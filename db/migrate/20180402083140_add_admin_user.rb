class AddAdminUser < ActiveRecord::Migration[5.1]
  def self.up
    User.create!(email: 'admin@example.com',
                 login: 'admin', password: '123456789',
                 first_name: 'John', last_name: 'Doe',
                 birthday: '2018-04-11', address: 'nowhere',
                 city: 'Nowhere City',
                 state: 'Nowhere State',
                 country: 'SuperCountry', zip: 0, role: 1)
  end

  def self.down
    admin_user = User.find_by_email('admin@example.com')
    admin_user.destroy
  end
end
