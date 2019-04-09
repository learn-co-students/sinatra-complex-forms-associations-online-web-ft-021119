
require 'pry'
class PetsController < ApplicationController

  get '/pets' do
    #binding.pry
    @pets = Pet.all
   
    erb :'/pets/index' 
  end

  get '/pets/new' do 
 @owner = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
  
  #binding.pry
  @pet = Pet.create(params[:pet])
  
  #binding.pry
  if !params["owner"]["name"].empty?
    @pet.owner = Owner.create(name: params["owner"]["name"])
    #binding.pry
  end
  #binding.pry
  @pet.save
  redirect "/pets/#{@pet.id}"
end

  get '/pets/:id' do 
    #binding.pry
    @pet = Pet.find(params[:id])
    #binding.pry
    erb :'/pets/show'
  end
   
   get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end
   
  

  patch '/pets/:id' do

   #binding.pry
    ####### bug fix
    # if !params[:pet].keys.include?("owner_id")
    # params[:pet]["owner_id"] = []
    # end
    #######
 
    @pet = Pet.find_by(params[:id])

    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect "/pets/#{@pet.id}"
  end
end