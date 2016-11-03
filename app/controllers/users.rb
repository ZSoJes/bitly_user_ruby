before '/new_user' do
  if params[:error] == 'true'
    @error = "Recuerda completar todos los campos!!!"
  end
end

get '/new_user' do
  erb :new_user
end

post '/new_user' do
  nuev_name = params[:name] 
  nuev_mail = params[:email]
  nuev_pass = params[:pass]

 usuario = User.create(name: nuev_name, password: nuev_pass, email: nuev_mail).valid?

  unless usuario
    redirect to '/new_user?error=true'
  else
    puts "agregado satisfactoriamente"
    redirect to '/'
  end

end