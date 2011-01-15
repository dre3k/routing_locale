class LocalesConstraints
  def self.matches?(request)
    request.params[:locale] =~ /\Aen|ua\z/
  end
end

RoutingLocale::Application.routes.draw do
  get "/", :to => redirect("/posts")

  constraints(LocalesConstraints) do
    scope '(/:locale)', :as => :locale do
      resources :posts
    end
  end

  # root :to => "posts#index"
end