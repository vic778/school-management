json.user do
  json.call(current_user, :id, :name, :email)
end
