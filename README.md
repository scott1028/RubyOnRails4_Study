# Rails4 Study
~~~
ref: http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json
ref: http://stackoverflow.com/questions/4443218/ror-nested-include-to-include-sub-resources-in-to-xml-to-json
ref: http://stackoverflow.com/questions/16426398/active-admin-install-with-rails-4
~~~
render json: @people, :include => [:roles => { include: [:privileges] } ]
~~~
~~~
- Controller Test Nestet JSON Operation Sample.
- Use Params.permit filter JSON Field.
~~~
{
  "id": 1,
  "label": "scott",
  "content": "test data",
  "created_at": "2015-08-22T03:15:30.148Z",
  "updated_at": "2015-08-22T03:15:30.148Z",
  "roles": [{
    "id": 1,
    "user_id": 1,
    "role_id": "test xxxxx",
    "created_at": "2015-08-22T03:17:59.023Z",
    "updated_at": "2015-08-22T03:17:59.023Z",
    "privileges": [

    ]
  }]
}
~~~

# ActiveRecord Nested Attributes
~~~
class Member < ActiveRecord::Base
  has_many :posts
  accepts_nested_attributes_for :posts, reject_if: proc { |attributes| attributes['title'].blank? }
end

params = { member: {
  name: 'joe', posts_attributes: [
    { title: 'Kari, the awesome Ruby documentation browser!' },
    { title: 'The egalitarian assumption of the modern citizen' },
    { title: '' } # this will be ignored because of the :reject_if proc
  ]
}}

member = Member.create(params[:member])
member.posts.length # => 2
member.posts.first.title # => 'Kari, the awesome Ruby documentation browser!'
member.posts.second.title # => 'The egalitarian assumption of the modern citizen'
~~~
- accepts_nested_attributes_for :posts mapping posts_attributes

# Strong Parameter Filter
~~~
One-to-many

Consider a member that has a number of posts:

class Member < ActiveRecord::Base
  has_many :posts
  accepts_nested_attributes_for :posts
end
You can now set or update attributes on the associated posts through an attribute hash for a member: include the key :posts_attributes with an array of hashes of post attributes as a value.

For each hash that does not have an id key a new record will be instantiated, unless the hash also contains a _destroy key that evaluates to true.

params = { member: {
  name: 'joe', posts_attributes: [
    { title: 'Kari, the awesome Ruby documentation browser!' },
    { title: 'The egalitarian assumption of the modern citizen' },
    { title: '', _destroy: '1' } # this will be ignored
  ]
}}

member = Member.create(params[:member])
member.posts.length # => 2
member.posts.first.title # => 'Kari, the awesome Ruby documentation browser!'
member.posts.second.title # => 'The egalitarian assumption of the modern citizen'
~~~
- accepts_nested_attributes_for :posts mapping posts_attributes

# ActiveAdmin
~~~
ref: http://stackoverflow.com/questions/5149773/how-to-create-the-first-admin-user-cancan-and-devise
ref: http://127.0.0.1:3000/admin
~~~
gem 'activeadmin', github: 'activeadmin'
gem 'devise'
~~~
- Create First AdminUser.
~~~
rails generate active_admin:install 
rake db:migrate
~~~
~~~
AdminUser.create!(:email=>'test@test.com',:password=>'password')
~~~

# RailsAdmin(推薦)
~~~
ref: https://github.com/sferik/rails_admin
~~~
~~~
gem 'rails_admin'
~~~
~~~
rails g rails_admin:install
~~~
# Rich Plugin
~~~
ref: https://github.com/kreativgebiet/rich
~~~
