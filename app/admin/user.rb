ActiveAdmin.register User do
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

  permit_params :first_name, :last_name, :email, :manager_id,
                user_user_groups_attributes: [:id, :user_group_id, :_destroy]

  filter :id
  filter :first_name
  filter :last_name
  filter :email

    # Index page definition
  index pagination_total: false do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email
    column :created_at
    actions
  end

  show do
    tabs do
      tab "Details" do
        attributes_table_for user do
          row :id
          row :first_name
          row :last_name
          row :email
          row "manager_id" do |u|
            u.manager_id
          end
        end
      end

      tab "User Groups" do
        table_for user.user_groups do
          column :id do |user_group|
            link_to user_group.id, admin_user_path(user_group.id)
          end
          column :name do |user_group|
            user_group.name
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
          f.input :first_name, required: true
          f.input :last_name
          f.input :email
          f.input :manager_id, label: "Manager ID"
        end
      end

      tab "User Groups" do
        f.inputs "Assign User to User Groups" do
          f.has_many :user_user_groups, new_record: "Assign to new User Group", allow_destroy: true do |ff|
            ff.semantic_errors *ff.object.errors.keys

            ff.input :user_group_id, required: true, as: :select, collection: (UserGroup.all.map{|u| [u.name, u.id]})
          end
        end
      end
    end
    f.actions
  end

end
