Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'

  scope :api, defaults: { format: :json } do
      devise_for :users, controllers: { registrations: :registrations, sessions: :sessions, confirmations: :confirmations},
                      path_names: { sign_in: :login, registration: :register }

      # devise_scope : do
      #     post 'register', to: 'registrations#create'
      #     put 'users/:id', to: 'registrations#update'
      # end

    resource :user, only: [:update, :show]
    get 'user/auto_login', to: 'users#auto_login'

  end
end
