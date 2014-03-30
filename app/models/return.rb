class Return < ActiveRecord::Base
  belongs_to :line
  def self.search(cur_b, des_b)
    if cur_b != " " && des_b != " "
      where('blocks_passed LIKE ? AND blocks_passed LIKE ?', "%#{cur_b}%", "%#{des_b}%")
    else
      return []
    end
  end

  def self.search_surroundings(cur_b, des_b)
    where('surroundings LIKE ? AND surroundings LIKE ?', "%#{cur_b}%", "%#{des_b}%")
  end

end