class GroupsController < ApplicationController
  
  def show
    set_tab('groups')    
    @group = Group.find(params[:id])
  end
  
end