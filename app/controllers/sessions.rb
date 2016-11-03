before '/user_session/:id' do
  if session[:user_id] == nil
    redirect to '/?error_1=true'
  end
end

get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  # @urls = Url.all
  @urls = Url.where(users_id: nil)
  if params[:error_1] == 'true'
     @error = "El acceso ha fallado, rectifique su correo y/o contraseña"
  elsif params[:error_2] == 'true'
     @error_2 = "Prueba con otra Url"
  end
  erb :index
end


post '/user_session' do
  @email = params[:email] 
  @pass = params[:pass]
  @user = User.authenticate(@email, @pass)

  if @user != nil
    session[:user_id] = @user.id
    redirect to "/user_session/#{@user.id}"
  else
    redirect to '/?error_1=true'
  end
end

get '/user_session/:id' do     # muestra un especifico usuario por su id
  erb :user
end
