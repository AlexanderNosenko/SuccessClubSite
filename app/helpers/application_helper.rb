module ApplicationHelper
    # TODO: improve this function to words count
    def truncate(str, length)
      str = str.to_s
      (str.length < length)? str : str[0..length] + "..."
    end
    def markdown(text) # thx to https://habrahabr.ru/company/centosadmin/blog/163947/
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
      options = {
          autolink: true,
          no_intra_emphasis: true,
          fenced_code_blocks: true,
          lax_html_blocks: true,
          strikethrough: true,
          superscript: true,
          space_after_headers: true
      }
      Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end
    def business_link
      link = (user_has_rights ? business_index_path : '#')
      htrml_classes = "menu-item " + is_active_controller('business/*').to_s + (user_has_rights ? "" : " disabled")
      raw(
        "<a class='#{htrml_classes}' href='#{}' data-toggle='modal', data-target='#tools-choose-business'>" +
        '<i class="fa fa-bank"></i>' +
        ( user_has_rights ? '' : '<span class="dis-popup">Временно недоступно</span>') +
        '<span class="full-menu">Бизнес</span></a>'
        )
    end
    def instruments_link
      link = (user_has_rights ? business_index_path : '#')
      htrml_classes = "menu-item " + is_active_controller('instruments/*').to_s + (user_has_rights ? "" : " disabled")
      raw(
        "<a class='#{htrml_classes}' href='#{}' data-toggle='modal', data-target='#tools-choose-instruments'>" +
        '<i class="fa fa-cogs"></i>' +
        ( user_has_rights ? '' : '<span class="dis-popup">Временно недоступно</span>') +
        '<span class="full-menu">Инструменты</span></a>'
        )
    end
    def get_view_mode(type)
      unless session[:menu_bar_view_mode].blank?
        if session[:menu_bar_view_mode] == 'minimized'
          reversed_menu_view_mode type
        else
          default_menu_view_mode type
        end
      else
        default_menu_view_mode type
      end
    end
    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def get_avatar(user, params = {})
      url = user.avatar_url
      url = 'no_avatar.png' if user.avatar_url.nil?
      image_tag(url, params)
    end

    def get_trasfer_money_form(servise)

     form = content_tag(:div, class: 'form-group') do
       form_tag servise['action'], method: 'POST', id: servise['name'] do |f|
          #fields = button_tag("Pay with #{servise['name']}")
          fields = ''
          servise['fields'].each { |key, value|  fields << hidden_field_tag(key, value)}
          fields.html_safe
        end
      end
      form.html_safe
    end
    private

    def default_menu_view_mode type
      if type == 'menu'
        'minimized'
      else
        'full'
      end
    end
    def reversed_menu_view_mode type
      if type == 'menu'
        'full'
      else
        'minimized'
      end
    end
end
