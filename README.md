# Records Manipulator for ActiveRecord

This gem consists of a simple extention to Active Record to allow you to specify manipulations for an array of records before they are returned from the database.

For example, if we have a `Post` model and we wanted to do something to it when it was returned from our database, we might do this:

```ruby
posts = Post.where(:published => true)
posts.each { |p| p.taint! }
```

That's fine but we had to define this at the end of our scope once we already had loaded the records from the array. This isn't very portable and doesn't allow any further chaining after you've made your changes.

With `manipulate` you can define a procedure to be executed when the records are actually returned from the database. You may wish to do this sort of thing with a presenter but sometimes that's overkill for a simple use case.

```ruby
posts = Posts.where(:published => true).manipulate do |records|
  records.each { |p| p.taint! }
end
```

After this has run, we still haven't actually made any queries but when we do we know that the posts will have the `taint!` method executed on them.

For a slightly more complex example, you might use this to include custom (non-AR) data for one of your classes. Let's say we want to preload the biography for all the users in our app from the Twitter API. Our user model might look like this:

```ruby
class User < ActiveRecord::Base
  def self.includes_twitter_bio
    manipulate do |records|
      # Get all our usernames for the records we're going to be rendering
      usernames = records.map(&:twitter_username)

      # Get the bios from the twitter API (this is psudocode). It accepts an array
      # of users and returns a hash of username to bio.
      author_bios = TwitterAPI.get_author_bios(author_usernames)

      # Add the bios to the users
      records.each do |user|
        user.instance_variable_set("@twitter_bio", author_bios[user.twitter_username])
      end
    end
  end

  def twitter_bio
    @twitter_bio ||= TwitterAPI.get_author_bio(self.twitter_username)
  end
end
```

Once you've added a method to your model, you can then easily use it wherever you want to pre-load this data. Here we're using it in combination with pagination. We'll only preload data for the users that are required for the requested page.

```ruby
class UsersController < ApplicationController

  def index
    users = User.includes_twitter_bio.page(params[:page])
  end

end
```

## Installation

```ruby
gem 'records_manipulator'
```
