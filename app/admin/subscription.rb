ActiveAdmin.register Subscription do
  scope_to :current_agency, :unless => proc{ current_user.has_role? :admin }

  permit_params :user_id, :alert_type_id

  index do
    column :user
    column :alert_type
    if current_user.has_role? :admin
      column 'Agency' do |subscription| 
        subscription.alert_type.agency.name
      end
    end
    column :created_at
  end
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
