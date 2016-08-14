module ApplicationHelper
    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def get_avatar(user)
      url = user.avatar_url
      url = '/images/no_avatar.png' if user.avatar_url.nil?
      image_tag(url, class: "profile-pic")
    end
end
