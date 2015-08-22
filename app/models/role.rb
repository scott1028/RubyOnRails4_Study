class Role < ActiveRecord::Base
    has_many :privileges, foreign_key: :role_id
    accepts_nested_attributes_for :privileges
end
