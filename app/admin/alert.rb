ActiveAdmin.register Alert do
  scope_to :current_agency, :unless => proc{ current_user.has_role? :admin }

  permit_params :body, :alert_type_id, :subject

  preserve_default_filters!

  index do
    column :id
    column :subject
    column :delivered?
    column :created_at
    column :agency if current_user.has_role? :admin

    default_actions
  end

  form do |f|
    f.inputs "Alert" do
      f.input :alert_type, :collection => current_user.agency.alert_types, :required => true
      f.input :subject, :required => true
      f.input :body, :required => true
    end

    f.actions
  end

  show do |alert|
    h3 "Alert Information"
    attributes_table do
      row :subject
      row :body
      row :alert_type
      row :sent_at
      row :subscribers do
        ul do
          alert.alert_type.subscriptions.each do |sub|
            li link_to(sub.user.name, admin_user_path(sub.user))
          end
        end
      end
    end
  end


end
