before "/user_session/:id" do 
  if params[:error] == 'true'
    @error = "Prueba con otra Url"
  end
end

get "/user_session/:id" do
  @urls = Url.where(users_id: session[:user_id])
  erb :user
end

post '/urls' do
  @short_url = params[:long_url]
  @id_user = session[:user_id]

  @short_url = Url.new.create_url_short
  @url = Url.create(long_url: params[:long_url], short_url: @short_url, users_id: @id_user)

  if @url.save
    redirect to "/user_session/#{session[:user_id]}"
  else
    redirect to "/user_session/#{session[:user_id]}?error=true"
  end
end

get '/end_session' do
  @current_user = session[:user_id] = nil
  redirect to '/'
end

get '/:short_url' do                        #captura del link y contador de visitas
  @dato = params[:short_url]
  @temp = "http://cow.lo/#{@dato}"

  x = Url.find_by(short_url: @temp)

  if x.nil?
    @temp = "https://cow.lo/#{@dato}" 
    x = Url.find_by(short_url: @temp)
  end

  x.click_count += 1
  x.save
  redirect to "#{x.long_url}"
end


post '/urls/public' do
  @short_url = params[:long_url]
  # @id_user = session[:user_id]

  @short_url = Url.new.create_url_short
  @url = Url.create(long_url: params[:long_url], short_url: @short_url)
    # , users_id: @id_user)

  if @url.save
    redirect to "/"
  else
    redirect to "/?error_2=true"
  end
end