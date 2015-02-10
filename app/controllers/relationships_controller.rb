class RelationshipsController < ApplicationController
  before_action :require_user

  def index; end

  def create
    user = User.find(params[:relation_id])
    Relationship.create(user: current_user, relation_id: params[:relation_id]) if 
                        current_user.can_follow?(user)
    redirect_to people_path
  end

  def destroy
    current_user.relationships.destroy(params[:id])
    redirect_to people_path
  end

end
