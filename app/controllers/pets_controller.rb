class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.owner = Owner.create(name: params["owner"]["name"])
      @pet.save
    end
    redirect "/pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    #erb :'/pets/show'
    erb :'pets/edit'
  end

  get '/pets/:id/' do#id=1
    @pet = Pet.find(params[:id])
    @pet.owner = params["pet"]["owner"]
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    params.delete("_method")

    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    #@pet.name = params(["pet"]["name"])
    #@pet.owner = params (["pet"]["owner"])

    unless params[:owner][:name].empty?
      @pet.owner = Owner.new(name: params[:owner][:name])
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
