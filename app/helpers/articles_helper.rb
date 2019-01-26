module ArticlesHelper

    def owner?(a)
        a == current_user.name
    end
end
