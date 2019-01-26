module CommentsHelper
    
    
    def authorized?(a)
       a == current_user.name
    end
end
