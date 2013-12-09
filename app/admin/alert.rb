ActiveAdmin.register Alert do
  scope_to :current_agency, :unless => proc{ current_user.has_role? :admin }

  permit_params :body

  preserve_default_filters!

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
      # row :agency
    end
  end
end
