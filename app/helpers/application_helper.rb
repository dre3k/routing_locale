def routes_helpers(*resources)
  postfixes = %w[_path _url]
  prefixes  = %w[edit_ new_] << ''
  resources.each do |resource|
    singular_name = resource.to_s
    plural_name = resource.to_s.pluralize
    postfixes.each do |postfix|
      PostsHelper.class_eval do
        define_method (name = plural_name + postfix).to_sym do |*args|
          if defined? params[:locale] and params[:locale]
            send(("user_locale_" + name).to_sym , params[:locale], *args)
          else
            send(("default_locale_" + name).to_sym, *args)
          end
        end
      end

      prefixes.each do |prefix|
        PostsHelper.class_eval do
          define_method (prefix + name = (singular_name + postfix)).to_sym do |*args|
            if defined? params[:locale] and params[:locale]
              send((prefix + "user_locale_" + name).to_sym , params[:locale], *args)
            else
              send((prefix + "default_locale_" + name).to_sym, *args)
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
