require('sinatra')
require('sinatra/reloader')
require('./lib/album')
require 'pry'
also_reload('lib/**/*.rb')

get('/') do
  @albums = Album.all
  erb(:albums)
end

get('/albums') do
  if params["search"]
    name = params[:search]
    @albums = Album.search(name)
  else
    @albums = Albums.all
  end
 erb(:albums)
end

get('/albums/:id/edit') do
  @album = Album.find(params[:id].to_i())
  erb(:edit_album)
end

get('/albums/new') do
  erb(:new_album)
end

post('/albums') do
  name = params[:album_name]
  year = params[:album_year]
  genre = params[:album_genre]
  artist = params[:album_artist]
  id = params[:id]
  album = Album.new(name, id, year, genre, artist)
  album.save()
  @albums = Album.all() # Adding this line will fix the error.
  erb(:albums)
end

patch('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.update(params[:name], params[:year], params[:genre], params[:artist]) #add params?
  @albums = Album.all
  erb(:albums)
end

delete('/albums/:id') do
  @album = Album.find(params[:id].to_i())
  @album.delete()
  @albums = Album.all
  erb(:albums)
end
