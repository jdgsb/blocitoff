# == Schema Information
#
# Table name: items
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ActiveRecord::Base
  belongs_to :user

  def days_left
   7 - (DateTime.now.utc.to_date - created_at.to_date).to_i
  end

end
