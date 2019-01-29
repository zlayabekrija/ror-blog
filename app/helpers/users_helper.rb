module UsersHelper
    def only_admin?
        current_user.name == 'admin'
      end
end
