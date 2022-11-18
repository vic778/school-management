json.call(user, :id, :name, :email, :rule)
json.token user.generate_jwt
