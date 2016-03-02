Rails.application.routes.draw do

  resources :schedule_statuses

  devise_for :users

  resources :comments

  resources :topics

  resources :flags

  resources :infomsgs
  post 'infomsgs/delete_by_admin' => 'infomsgs#deleteByAdmin'

  get 'menu/show'

  root to: 'menu#show'

  resources :inspection_results

  resources :notes

  resources :measurements

  resources :checks

  resources :weathers

  resources :checkresults

  resources :inspection_schedules do
    collection do
      get 'need_request'
      get 'requested_soon'
      get 'date_answered'
      get 'target'
      get 'done'
    end
  end

  # 点検を依頼する
  get 'inspection_schedules/:id/inspection_request' => 'inspection_schedules#inspection_request' , as: 'inspection_request'

  # 候補日時を回答する
  get 'inspection_schedules/:id/answer_date' => 'inspection_schedules#answer_date' , as: 'answer_date'

  # 日程確定する
  get 'inspection_schedules/:id/confirm_date' => 'inspection_schedules#confirm_date' , as: 'confirm_date'

  # 点検を実施する
  get 'inspection_schedules/:id/do_inspection' => 'inspection_schedules#do_inspection' , as: 'do_inspection'

  # 点検を承認する(顧客にサインをもらう)
  get 'inspection_schedules/:id/done_inspection' => 'inspection_schedules#done_inspection' , as: 'done_inspection'
  post 'inspection_schedules/:id/approve_inspection' => 'inspection_schedules#approve_inspection'

  # 点検を完了する
  get 'inspection_schedules/:id/close_inspection' => 'inspection_schedules#close_inspection', as: 'close_inspection'
  post 'inspection_schedules/:id/complete_inspection' => 'inspection_schedules#complete_inspection'

  # 同一設置場所の装置システムを表示 ⇒ 点検周期を一括変更する
  get 'equipment/placed_equipment/:place_id' => 'equipment#placed_equipment', as: 'placed_equipment'
  post 'equipment/placed_equipment/change_inspection_cycle' => 'equipment#change_inspection_cycle'

  resources :equipment do
    collection { post :import }  # for CSV Upload
  end

  resources :places do
    collection { post :import }  # for CSV Upload
  end

  resources :system_models

  resources :users do
    collection { post :import }  # for CSV Upload
  end

  resources :companies


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
