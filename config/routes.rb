Rails.application.routes.draw do
  root to: 'menu#show'

  resources :users do
    collection { post :import }  # for CSV Upload
  end
  devise_for :users

  resources :topics

  resources :comments

  resources :infomsgs
  post 'infomsgs/delete_by_admin' => 'infomsgs#delete_by_admin'

  resources :inspection_schedules do
    collection do
      get 'need_request'
      get 'requested_soon'
      get 'date_answered'
      get 'target'
      get 'done'
    end
  end

  get 'inspection_schedules/:id/inspection_request' => 'inspection_schedules#inspection_request' , as: 'inspection_request'
  get 'inspection_schedules/:id/answer_date' => 'inspection_schedules#answer_date' , as: 'answer_date'
  get 'inspection_schedules/:id/confirm_date' => 'inspection_schedules#confirm_date' , as: 'confirm_date'
  get 'inspection_schedules/:id/do_inspection' => 'inspection_schedules#do_inspection' , as: 'do_inspection'
  get 'inspection_schedules/:id/done_inspection' => 'inspection_schedules#done_inspection' , as: 'done_inspection'
  post 'inspection_schedules/:id/approve_inspection' => 'inspection_schedules#approve_inspection'
  get 'inspection_schedules/:id/close_inspection' => 'inspection_schedules#close_inspection', as: 'close_inspection'
  post 'inspection_schedules/:id/complete_inspection' => 'inspection_schedules#complete_inspection'
  get 'inspection_schedules/:id/correct_targetyearmonth' => 'inspection_schedules#correct_targetyearmonth' , as: 'correct_targetyearmonth'

  resources :inspection_results, only: %i(show new create edit update destroy)

  resources :equipment do
    collection do
      post :import  # for CSV Upload
      get :change_system_model
      get :change_inspection_contract
    end
  end
  # 同一設置場所の装置システムを表示
  get 'equipment/placed_equipment/:place_id' => 'equipment#placed_equipment', as: 'placed_equipment'
  # 点検周期を一括変更する
  post 'equipment/placed_equipment/:place_id/change_inspection_cycle' => 'equipment#change_inspection_cycle', as: 'change_inspection_cycle'

  resources :places do
    collection { post :import }  # for CSV Upload
  end

  resources :system_models

  resources :companies
end
