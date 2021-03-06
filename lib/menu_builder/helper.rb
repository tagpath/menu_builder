module MenuBuilder
  module ViewHelpers
    class Menu
      def initialize(context)
        @context = context
        @menu_items = @context.instance_variable_get('@menu_items')
      end

      def included_in_current_items?(item)
        @menu_items.present? && @menu_items.include?(item.to_sym)
      end

      def method_missing(item, *args, &block)
        css_class = "current" if included_in_current_items? item
        @context.content_tag :li, @context.link_to(*args, &block), :class=>css_class
      end
    end

    def menu(options={}, &block)
      content_tag :ul, capture(Menu.new(self), &block), options
    end
  end
end