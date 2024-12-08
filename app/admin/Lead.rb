ActiveAdmin.register Lead do
  actions :all, except: [:edit, :update, :destroy]

end
