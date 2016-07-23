%w(/ /ideas).each do |path|
  get path do
    @ideas = Idea.all
    erb :'ideas/index'
  end
end


%w(/new /ideas/new).each do |path|
  get path do
    @title = 'New Idea'
    @idea  = Idea.new
    erb :'ideas/new'
  end
end
  post '/ideas' do
  if params[:idea]
    @idea           = Idea.new(params[:idea])
    if params[:idea][:picture] && params[:idea][:picture][:filename] && params[:idea][:picture][:tempfile]
      filename      = params[:idea][:picture][:filename]
      @idea.picture = filename
      file          = params[:idea][:picture][:tempfile]
      FileUtils.copy_file(file.path,"files/#{@idea.picture}")
    end
    if @idea.save
      redirect '/ideas'
    else
      erb :'ideas/new'
    end
  else
    erb :'ideas/new'
  
end
end