ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message", :style => "margin-bottom: 20px;" do
      # span :class => "blank_slate" do
        # span I18n.t("active_admin.dashboard_welcome.welcome")
        # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      # end
      image_tag "logo-whuut.jpg"
    end

    columns do
      column do
        panel "Welcome" do
          para "Welcome to the Alert Center administration dashboard."
        end
      end
    end

    columns do

      column do
        panel "Recent Alerts" do
          ul do
            Alert.recent(10).map do |alert|
              li link_to(alert.subject, admin_alert_path(alert))
            end
          end
        end
      end

      column do
        panel "Most Recent Subscriptions" do
          ul do
            Subscription.recent(10).map do |sub|
              li link_to(sub.user.name, admin_subscription_path(sub))
            end
          end
        end
      end
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
