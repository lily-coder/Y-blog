module UsersHelper
  def user_img(user)
    user.photo.present? ? user.photo : '/user.png'
  end
end
