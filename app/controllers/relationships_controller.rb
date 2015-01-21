class RelationshipsController < ApplicationController
  before_action :require_user

  def create
    current_user.relationships.create(relation_id: params[:relation_id])
    flash[:success] = "You are now following the user!"
    redirect_to people_path
  end

  def destroy
    current_user.relationships.destroy(params[:id])
    redirect_to people_path
  end
end
