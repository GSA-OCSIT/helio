ActiveAdmin.register Alert do
  scope_to :current_agency, :unless => proc{ current_user.has_role? :admin }

  permit_params :body, :alert_type_id, :subject, :zip, :is_parent, :gender

  preserve_default_filters!

  index do
    column :id
    column "Type" do |alert|
      alert.alert_type.name
    end
    column :subject
    column :delivered?
    column :zip
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

    f.inputs "Targeting" do
      f.input :zip
      f.input :gender, :as => :select, :collection => ['male','female']
      f.input :is_parent, :label => "Parents"
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
          alert.subscribers.each do |sub|
            li link_to(sub.name, admin_user_path(sub))
          end
          li "None" if alert.subscribers.empty?
        end
      end
    end
  end


end
