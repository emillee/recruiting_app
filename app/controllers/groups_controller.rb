class GroupsController < ApplicationController

	before_filter :set_this_tab, only: [:show]
  
  def show
    @group = Group.find(params[:id])
  end

  private

  	def set_this_tab
  		set_tab('groups')   
  	end
  
end