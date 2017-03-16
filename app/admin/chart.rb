ActiveAdmin.register Chart do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :name, :user_group_id,
                chart_users_attributes: [:id, :user_id, :rank, :_destroy]

  filter :id
  filter :name
  filter :user_group

    # Index page definition
  index pagination_total: false do
    selectable_column
    id_column
    column :name
    column :user_group
    column :created_at
    actions
  end

  show do
    tabs do
      tab "Details" do
        attributes_table_for chart do
          row :id
          row :name
          row :user_group
        end
      end

      tab "Users" do
        table_for chart.chart_users do
          column :id do |chart_user|
            link_to chart_user.user.id, admin_user_path(chart_user.user.id)
          end
          column :rank do |chart_user|
            chart_user.rank
          end
          column :first_name do |chart_user|
            chart_user.user.first_name
          end
          column :last_name do |chart_user|
            chart_user.user.last_name
          end
          column :email do |chart_user|
            chart_user.user.email
          end
          column :manager_id do |chart_user|
            chart_user.user.manager_id
          end
        end
      end
    end
  end

  form multipart: true do |f|
    tabs do
      f.semantic_errors *f.object.errors.keys
      tab "Details" do
        f.inputs "Details" do
          f.input :name, required: true
          if object.new_record?
            f.input :user_group, required: true
          else
            f.input :user_group, :input_html => { disabled: true }
          end
        end
      end

      if !object.new_record?
        tab "Users" do
          f.inputs "Users" do
            f.has_many :chart_users, new_record: "Add a User to Chart", allow_destroy: true do |ff|
              ff.semantic_errors *ff.object.errors.keys

              ff.input :user_id, required: true, as: :select, collection: (chart.user_group.users.map{|u| [u.first_name + " - " + u.email, u.id]})
              ff.input :rank
            end
          end
        end
      end
    end
    f.actions
  end

end
