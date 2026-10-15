Rails.application.routes.draw do
  mount Mensa::Engine => "/mensa"
  mount Distribuo::Engine => '/distribuo'
end
