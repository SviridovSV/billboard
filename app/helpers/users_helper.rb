module UsersHelper
  def coordinates(user)
    [user.latitude, user.longitude].join(',')
  end

  def full_addr
    "#{@user.zip}, #{@user.country.capitalize}, #{@user.state.capitalize}, #{@user.city.capitalize}, #{@user.address}"
  end
end
