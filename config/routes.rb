# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                                videos GET    /videos(.:format)                                                                        videos#index
#                                       POST   /videos(.:format)                                                                        videos#create
#                             new_video GET    /videos/new(.:format)                                                                    videos#new
#                            edit_video GET    /videos/:id/edit(.:format)                                                               videos#edit
#                                 video GET    /videos/:id(.:format)                                                                    videos#show
#                                       PATCH  /videos/:id(.:format)                                                                    videos#update
#                                       PUT    /videos/:id(.:format)                                                                    videos#update
#                                       DELETE /videos/:id(.:format)                                                                    videos#destroy
#                               invites GET    /invites(.:format)                                                                       invites#index
#                                       POST   /invites(.:format)                                                                       invites#create
#                            new_invite GET    /invites/new(.:format)                                                                   invites#new
#                                invite DELETE /invites/:id(.:format)                                                                   invites#destroy
#                         opportunities GET    /opportunities(.:format)                                                                 opportunities#index
#                                       POST   /opportunities(.:format)                                                                 opportunities#create
#                       new_opportunity GET    /opportunities/new(.:format)                                                             opportunities#new
#                      edit_opportunity GET    /opportunities/:id/edit(.:format)                                                        opportunities#edit
#                           opportunity GET    /opportunities/:id(.:format)                                                             opportunities#show
#                                       PATCH  /opportunities/:id(.:format)                                                             opportunities#update
#                                       PUT    /opportunities/:id(.:format)                                                             opportunities#update
#                                       DELETE /opportunities/:id(.:format)                                                             opportunities#destroy
#                                events GET    /events(.:format)                                                                        events#index
#                                       POST   /events(.:format)                                                                        events#create
#                             new_event GET    /events/new(.:format)                                                                    events#new
#                            edit_event GET    /events/:id/edit(.:format)                                                               events#edit
#                                 event GET    /events/:id(.:format)                                                                    events#show
#                                       PATCH  /events/:id(.:format)                                                                    events#update
#                                       PUT    /events/:id(.:format)                                                                    events#update
#                                       DELETE /events/:id(.:format)                                                                    events#destroy
#                                 users GET    /users(.:format)                                                                         users#index
#                                       POST   /users(.:format)                                                                         users#create
#                              new_user GET    /users/new(.:format)                                                                     users#new
#                             edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                                  user GET    /users/:id(.:format)                                                                     users#show
#                                       PATCH  /users/:id(.:format)                                                                     users#update
#                                       PUT    /users/:id(.:format)                                                                     users#update
#                                       DELETE /users/:id(.:format)                                                                     users#destroy
#                                 login GET    /login(.:format)                                                                         sessions#new
#                                       POST   /login(.:format)                                                                         sessions#create
#                                logout DELETE /logout(.:format)                                                                        sessions#destroy
#                                signup GET    /signup(.:format)                                                                        users#new
#                                  root GET    /                                                                                        pages#index
#                               contact GET    /contact(.:format)                                                                       pages#contact
#                                 about GET    /about(.:format)                                                                         pages#about
#                                       GET    /opportunities(.:format)                                                                 pages#opportunities
#                                 slack GET    /slack(.:format)                                                                         pages#slack
#                             resources GET    /resources(.:format)                                                                     pages#resources
#                                       GET    /check.txt(.:format)                                                                     #<Proc:0x000056202436e738@/home/vardy/coding/yegrb.com/config/routes.rb:93>
#           rails_amazon_inbound_emails POST   /rails/action_mailbox/amazon/inbound_emails(.:format)                                    action_mailbox/ingresses/amazon/inbound_emails#create
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  resources :videos
  resources :invites, except: [:edit, :update, :show]
  resources :opportunities
  resources :events

  # users
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'

  # static pages
  root 'pages#index'
  get '/contact', to: 'pages#contact'
  get '/about', to: 'pages#about'
  get '/opportunities', to: 'pages#opportunities'
  get '/slack', to: 'pages#slack'
  get '/resources', to: 'pages#resources'

  get '/check.txt', to: proc {[200, {}, ['it_works']]}
end

