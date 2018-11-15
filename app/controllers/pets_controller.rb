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
    @pet = Pet.create(params[:])
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    redirect to "pets/#{@pet.id}"
  end
end


  post '/owners' do 
    @owner = Owner.create(params[:owner]) 
    
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end 
    
    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do 
    @owner = Owner.find(params[:id])
    @pets = Pet.all
    erb :'/owners/edit'
  end

  get '/owners/:id' do 
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  patch '/owners/:id' do 
    if !params[:owner].keys.include?("pet_ids")
    params[:owner]["pet_ids"] = []
    end
    
    @owner = Owner.find(params[:id])
    @owner.update(params["owner"])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    redirect "owners/#{@owner.id}"
  end
end
