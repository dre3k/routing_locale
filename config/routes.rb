class LocaleConstraints
  def self.matches?(request)
    request.params[:locale] =~ /\Aen|ua\z/ or request.params[:locale] == nil
  end
end

RoutingLocale::Application.routes.draw do
  constraints(LocaleConstraints) do
    scope '(/:locale)', :as => :locale do
      root :to => "home#index"
      resources :posts
    end
  end
end