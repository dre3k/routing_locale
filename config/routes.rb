class NotDefaultLocale
  def self.matches?(request)
    request.params[:locale] !~ /\Aru\z/
  end
end

RoutingLocale::Application.routes.draw do
  get "/posts", :to => redirect("/")

  constraints(NotDefaultLocale) do
    scope '/:locale', :as => :user_locale do
      resources :posts
    end
  end

  scope :as => :default_locale do
    resources :posts
  end

  root :to => "posts#index"
end