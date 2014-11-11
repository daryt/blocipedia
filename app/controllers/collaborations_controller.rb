class CollaborationsController < ApplicationController
  def index
    @users = User.all
  end
  def show
   
  end

  def save
    @collabs = params[:collaborators]
    Collaboration.delete_all(wiki_id: params[:wiki_id])
    unless params[:collaborators].nil?
      for user_id in params[:collaborators]
        Collaboration.create(wiki_id: params[:wiki_id], user_id: user_id)
      end
    end

  end

  def edit

  end
end
