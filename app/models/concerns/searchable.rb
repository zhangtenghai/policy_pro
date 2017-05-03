module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    # usage: quick_search :no, :user_name
    # then that class has scope with name search(keyword)
    def quick_search(*columns)
      scope :quick_search, ->(keyword) { where "#{columns.map { |column| table_name+'.'+column.to_s + ' like :key' }.join(' or ')}", key: "%" + (keyword.nil? ? "" : keyword.rstrip.lstrip) + "%" unless keyword.blank?}
    end
  end
end