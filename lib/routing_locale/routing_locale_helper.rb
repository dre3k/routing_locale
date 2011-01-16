module RoutingLocaleHelper
  POSTFIXES = %w[_path _url]

  EXPLICIT_LOCALE_ROUTES = Rails.application.routes.routes.
    reject{|r| (r.path =~ %r[/rails/info/properties]) || r.name.nil?}.
    map{|r| r.name.to_s}.reject{|r| r !~ /locale_/}

  IMPLICIT_LOCALE_ROUTES = EXPLICIT_LOCALE_ROUTES.map{|r| r.sub('locale_', '')}

  def self.included(base)
    base.instance_eval do
      POSTFIXES.each do |postfix|
        EXPLICIT_LOCALE_ROUTES.each_with_index do |explicit_route, i|
          implicit_route = IMPLICIT_LOCALE_ROUTES[i]

          define_method (implicit_route + postfix).to_sym do |*args|
            send (explicit_route + postfix).to_sym, params[:locale], *args
          end
        end
      end
    end
  end
end
