require 'will_paginate/array'
module WillPaginate
  module ActionView

    def will_paginate(collection = nil, options = {})
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end

    class BootstrapLinkRenderer < LinkRenderer
      protected

      def html_container(html)
        tag(:ul, html, container_attributes)
      end

      def page_number(page)
        tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
      end

      def previous_or_next_page(page, text, classname)
        tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
      end

      def gap
        tag :li, link(super, '#'), :class => 'disabled'
      end

    end
    class CustomLinkRenderer < LinkRenderer
      protected

      def html_container(html)
        tag(:div, html, :class => "pagination")
      end

      def page_number(page)
        link(page, page, :rel => rel_value(page), :class => ("number " + if page == current_page then 'active' else '' end))
      end

      def previous_or_next_page(page, text, classname)
        link("", page || '#', :class => [classname[0..3], classname, "arrow-"+text].join(' '))
      end

      def gap
        link(super, '#', :class => 'disabled')
      end

    end
  end
end
