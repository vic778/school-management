Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, confirmations: :confirmations},
                     path_names: { sign_in: :login }

    resource :user, only: [:update, :show]
    get 'user/auto_login', to: 'users#auto_login'

  end
end
