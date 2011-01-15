def routes_helpers(*resources)
  postfixes = %w[_path _url]
  prefixes  = %w[edit_ new_] << ''
  resources.each do |resource|
    singular_name = resource.to_s
    plural_name = resource.to_s.pluralize
    postfixes.each do |postfix|
      self.class_eval do
        define_method (name = plural_name + postfix).to_sym do |*args|
          if defined? params[:locale] and params[:locale]
            send(("locale_" + name).to_sym , params[:locale], *args)
          else
            send(("locale_" + name).to_sym, nil, *args)
          end
        end
      end

      prefixes.each do |prefix|
        self.class_eval do
          define_method (prefix + name = (singular_name + postfix)).to_sym do |*args|
            if defined? params[:locale] and params[:locale]
              send((prefix + "locale_" + name).to_sym , params[:locale], *args)
            else
              send((prefix + "locale_" + name).to_sym, nil, *args)
            end
          end
        end
      end
    end
  end
end

module ApplicationHelper
  routes_helpers :post
end
