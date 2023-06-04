ActiveAdmin.register(Skin) do
  menu priority: 7

  includes :steam_account

  permit_params Skin.permitted_params
end
