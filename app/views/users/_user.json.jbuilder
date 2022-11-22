json.call(user, :id, :name, :email)
json.role user.role.name
json.token user.generate_jwt
