require 'csv'
class User < ApplicationRecord
  include Searchable
  quick_search :name, :phone, :address
  validates_presence_of :name, :phone, :address

  paginates_per 30

  def self.to_csv
    CSV.generate do |csv|
      csv << ["名字","电话","省","市","区","地址","录入时间"]
      all.each do |user|
        csv << [user.name, user.phone,user.province, user.city, user.district, user.address, user.created_at.strftime("%Y-%m-%d %H:%M:%S")]
      end
    end
  end
end
