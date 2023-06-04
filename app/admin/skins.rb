ActiveAdmin.register(Skin) do
  menu priority: 7

  permit_params Skin.permitted_params
end
