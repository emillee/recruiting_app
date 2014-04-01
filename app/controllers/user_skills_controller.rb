class UserSkillsController < ApplicationController

  respond_to :json, :js

  # RESTful Routes ---------------------------------------------------------------------------
  
  def create
    @user = User.find(params[:user_id])
    UserSkill.create(user_id: @user.id, skill: params[:skill])
    redirect_to user_url(@user)
  end
  
  def update 
    @userskill = UserSkill.find(params[:id])
    @userskill.update_attributes(user_skill_params)
    redirect_to user_url(current_user)
  end
  
  def destroy
    @userskill = UserSkill.find(params[:id]).destroy
    redirect_to user_url(current_user)
  end
  
	# PRIVATE -----------------------------------------------------------------------------------
  private
  
    def user_skill_params 
      params.require(:user_skill).permit(:user_id, :skill, :level)
    end

end