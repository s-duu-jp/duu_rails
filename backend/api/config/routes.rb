Rails.application.routes.draw do
  scope '/api' do
    get 'up' => 'rails/health#show', :as => :rails_health_check
  end
end
