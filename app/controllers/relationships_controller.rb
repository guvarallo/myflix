class RelationshipsController < ApplicationController

  def create
    relationship = current_user.relationships.build(relation_id: params[:relation_id])
    if relationship.save
      redirect_to people_path
    else
      redirect_to root_path
    end
  end

  def destroy

  end
end
