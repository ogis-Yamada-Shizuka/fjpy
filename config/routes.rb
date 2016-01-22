Rails.application.routes.draw do

  resources :comments

  resources :topics

  resources :flags

  resources :infomsgs
  post 'infomsgs/delete_by_admin' => 'infomsgs#deleteByAdmin'

  get 'menu/show'

  root to: 'menu#show'

  resources :kirokus

  resources :notes

  resources :measurements

  resources :checks

  resources :weathers

  resources :checkresults

  resources :inspections

  # 点検を実施する
  get 'inspections/:id/do_inspection' => 'inspections#do_inspection' , as: 'do_inspection'
  get 'inspections/:id/done_inspection' => 'inspections#done_inspection' , as: 'done_inspection'

  # 点検を完了(StatusをDoneに）する
  post 'inspections/:id/close_inspection' => 'inspections#closeInspection'

  resources :results

  resources :statuses

  resources :equipment do
    collection { post :import }  # for CSV Upload 
  end

  resources :places do
    collection { post :import }  # for CSV Upload 
  end

  resources :types

  resources :workers do
    collection { post :import }  # for CSV Upload 
  end

  resources :divisions

# 設備の点検予定を作成する
  get 'noinspection_list' => 'equipment#noInspectionList'
  post 'create_inspections' => 'inspections#createInspections'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
