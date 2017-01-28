module UsersHelper

    def get_role(uid)
        role = User.find_by_id(uid).role
        if role == 0
            role_name = "Admin"
        elsif role == 1
            role_name = "Moderator"
        else
            role_name = "User"
        end

        return role_name
    end
end
