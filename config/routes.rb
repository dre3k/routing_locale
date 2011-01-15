class NotDefaultLocale
  def self.matches?(request)
    request.params[:locale] !~ /\Aru\z/
  end
end

RoutingLocale::Application.routes.draw do
  get "/", :to => redirect("/posts")

  constraints(NotDefaultLocale) do
    scope '(/:locale)', :as => :locale do
      resources :posts
    end
  end

  # root :to => "posts#index"
end