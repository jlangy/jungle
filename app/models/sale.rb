class Sale < ActiveRecord::Base


  # self.method creates class method. Can do Sale.active now
  def self.active
    where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def avtive? 
    !upcoming? && !finished?
  end
end
