class LocaleConstraints
  def self.matches?(request)
    request.params[:locale] =~ /\Aen|ua\z/ or request.params[:locale] == nil
  end
end

RoutingLocale::Application.routes.draw do
  root :controller => :home, :action => :index, :locale => nil

  constraints(LocaleConstraints) do
    scope '(/:locale)', :as => :locale do
      resources :posts
      root :controller => :home, :action => :index
    end
  end
end

# IMPORTANT: have to be the last line in routes.rb
require 'routing_locale/routing_locale_helper'