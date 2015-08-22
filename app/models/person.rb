class Person < ActiveRecord::Base
    has_many :roles, foreign_key: :user_id

    # ref: http://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-permit
    # ref: http://api.rubyonrails.org/classes/ActiveRecord/NestedAttributes/ClassMethods.html
    # This make Model accept json format: {  roles_attributes: [...] }
    accepts_nested_attributes_for :roles
end
