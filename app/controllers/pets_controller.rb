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
    unless params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id/edit' do
    redirect to("/pets/#{params[:id]}/edit")
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    params.delete("_method")
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    unless params[:owner][:name].empty?
      @pet.owner = Owner.new(name: params[:owner][:name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
