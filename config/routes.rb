# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
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
#                      new_user_session GET    /users/sign_in(.:format)                                                                 users/sessions#new
#                          user_session POST   /users/sign_in(.:format)                                                                 users/sessions#create
#                  destroy_user_session DELETE /users/sign_out(.:format)                                                                users/sessions#destroy
#                     new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#                    edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                         user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                                       PUT    /users/password(.:format)                                                                devise/passwords#update
#                                       POST   /users/password(.:format)                                                                devise/passwords#create
#              cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#                 new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#                edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#                     user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                                       PUT    /users(.:format)                                                                         devise/registrations#update
#                                       DELETE /users(.:format)                                                                         devise/registrations#destroy
#                                       POST   /users(.:format)                                                                         devise/registrations#create
#                                  root GET    /                                                                                        pages#index
#                               contact GET    /contact(.:format)                                                                       pages#contact
#                                 about GET    /about(.:format)                                                                         pages#about
#                                       GET    /opportunities(.:format)                                                                 pages#opportunities
#                                 slack GET    /slack(.:format)                                                                         pages#slack
#                             resources GET    /resources(.:format)                                                                     pages#resources
#                                       GET    /check.txt(.:format)                                                                     #<Proc:0x000055696d4d4ff0@/home/vardy/coding/yegrb.com/config/routes.rb:13>
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
  resources :opportunities
  resources :events

  root 'pages#index'
  get '/contact' , to: 'pages#contact'
  get '/about' , to: 'pages#about'
  get '/opportunities' , to: 'pages#opportunities'
  get '/slack' , to: 'pages#slack'
  get '/resources' , to: 'pages#resources'

  get '/check.txt', to: proc {[200, {}, ['it_works']]}
end

