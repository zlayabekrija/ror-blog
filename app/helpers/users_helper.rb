module UsersHelper
    def only_admin?
        if !current_user.nil?
        current_user.user_level == 0
        else 
            false
        end
    end
end
