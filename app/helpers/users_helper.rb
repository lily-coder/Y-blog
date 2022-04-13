module UsersHelper
  def user_img(user)
    user.avatar.present? ? user.avatar : '/user.png'
  end
end
