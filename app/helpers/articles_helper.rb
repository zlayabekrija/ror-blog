module ArticlesHelper

    def owner?(a)
        a == current_user.name
    end
    def correct_user?(a)
        return false if current_user.nil?
        a == current_user.name
    end
    
end
