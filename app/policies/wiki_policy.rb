class WikiPolicy < ApplicationPolicy

  def show?
    user.id == record.user_id or Collaboration.where(:user_id => user.id).length > 0
    #scope.where(:id => record.id).exists?
    #wiki_user = Wiki.find(record.id).user
    #current_wiki = Wiki.find(params[:id])
    #collaborations = Collaboration.where(:user_id => user)
    #collab_wikis = Wiki.where(id: collaborations.pluck(:wiki_id))
    #collab_wikis.include?(current_wiki)
  end

  def add_collaborators?
    user.premium? and record.is_private?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role?(:admin)
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role?(:premium)
        collaborations = Collaboration.where(:user_id => user)
        collab_wikis = Wiki.where(id: collaborations.pluck(:wiki_id))
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.is_private || wiki.user_id == user.id || collab_wikis.include?(wiki)
            wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
          end
        end
      else # this is the lowly standard user
        collaborations = Collaboration.where(:user_id => user)
        collab_wikis = Wiki.where(id: collaborations.pluck(:wiki_id))
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.is_private? || wiki.user_id == user.id || collab_wikis.include?(wiki)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end

end
