class AddInterestedInMeeting < ActiveRecord::Migration
  def change
    add_column :users, :interested_in_meeting, :text
  end
end
