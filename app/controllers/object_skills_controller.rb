class ObjectSkillsController < ApplicationController

  respond_to :json, :js

  # RESTful Routes ---------------------------------------------------------------------------
  
  def create
    if params[:user_id]
      @user = User.find(params[:user_id])
      ObjectSkill.create(user_id: @user.id, skill_id: params[:skill_id])
      redirect_to user_url(@user)
    elsif params[:company_id]
      @company = Company.find(params[:company_id])
      ObjectSkill.create(company_id: @company.id, skill_id: params[:skill_id])
      redirect_to company_url(@company)
    end
  end
  
  def update 
    @object_skill = ObjectSkill.find(params[:id])
    @object_skill.update_attributes(object_skill_params)
    redirect_to user_url(current_user)
  end
  
  def destroy
    @object_skill = ObjectSkill.find(params[:id]).destroy
    redirect_to user_url(current_user)
  end
  
	# PRIVATE -----------------------------------------------------------------------------------
  private
  
    def object_skill_params 
      params.require(:object_skill).permit(:user_id, :company_id, :skill_id, :level)
    end

end