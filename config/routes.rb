class LocaleConstraints
  def self.matches?(request)
    request.params[:locale] =~ /\Aen|ua\z/ or request.params[:locale] == nil
  end
end

RoutingLocale::Application.routes.draw do
  root :to => redirect("/posts")

  constraints(LocaleConstraints) do
    scope '(/:locale)', :as => :locale do
      resources :posts
    end
  end
end