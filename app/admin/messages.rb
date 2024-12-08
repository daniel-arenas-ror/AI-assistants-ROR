ActiveAdmin.register Message do
  actions :all, except: [:edit, :update, :destroy]

end
