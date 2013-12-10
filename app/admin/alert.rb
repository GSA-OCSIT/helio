ActiveAdmin.register Alert do
  scope_to :current_agency, :unless => proc{ current_user.has_role? :admin }

  permit_params :body, :alert_type_id

  preserve_default_filters!

  index do
    column :id
    column :body
    column :delivered?
    column :created_at
    column :agency if current_user.has_role? :admin

    default_actions
  end

  form do |f|
    f.inputs "Alert" do
      f.input :alert_type, :collection => current_user.agency.alert_types, :required => true
      f.input :body, :required => true
    end

    f.actions
  end

  show do |alert|
    h3 "Alert Information"
    attributes_table do
      row :body
      row :alert_type
    end
  end


end
