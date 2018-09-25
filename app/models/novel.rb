class Novel < ApplicationRecord
  belongs_to :user

  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (name_matches(param)+description_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.name_matches(param)
    matches('name', param)
  end

  def self.description_matches(param)
    matches('description', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end
end
