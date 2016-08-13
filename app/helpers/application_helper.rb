module ApplicationHelper
    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def get_avatar(user)
      if user.nil? || user.avatar.nil?
        image_tag('/images/no_avatar.png')
      else
        image_tag user.avatar
      end
    end
end
