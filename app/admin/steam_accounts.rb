ActiveAdmin.register(Steam::Account) do
  menu priority: 6

  includes :enterprise, :owner

  permit_params Steam::Account.permitted_params

  filter :steam_id
  filter :steam_custom_id
  filter :nickname
  filter :real_name
  filter :enterprise

  index do
    selectable_column
    id_column
    column :steam_id
    column :steam_custom_id
    column :nickname
    column :real_name
    column :owner
    column :enterprise
    column :active
    actions
  end
end
