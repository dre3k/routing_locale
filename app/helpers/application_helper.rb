def routing_locale_helpers(*resources)
  postfixes = %w[_path _url]
  prefixes  = %w[edit_ new_] << ''
  resources.each do |resource|
    singular_name = resource.to_s
    plural_name = resource.to_s.pluralize
    postfixes.each do |postfix|
      self.class_eval do
        define_method (name = plural_name + postfix).to_sym do |*args|
          locale = (defined? params[:locale]) && (locale = params[:locale]) ? locale : nil
          send(("locale_" + name).to_sym , locale, *args)
        end
      end

      prefixes.each do |prefix|
        self.class_eval do
          define_method (prefix + name = (singular_name + postfix)).to_sym do |*args|
            locale = (defined? params[:locale]) && (locale = params[:locale]) ? locale : nil
            send((prefix + "locale_" + name).to_sym , locale, *args)
          end
        end
      end
    end
  end
end

module ApplicationHelper
  routing_locale_helpers :post
end
