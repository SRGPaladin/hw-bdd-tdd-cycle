# Add a declarative step here for populating the DB with movies.

num_movies = 0

Given /the following movies exist/ do |movies_table|
  num_movies = 0
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
    num_movies += 1
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should match /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings = rating_list.split(", ")
  ratings.each do |rating|
    if uncheck
      uncheck("ratings["+rating.strip+"]")
    else
      check("ratings["+rating.strip+"]")
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  
  #Simply checks to see that the number of elements in the column match the number of movies
  page.should have_css("table#movies tbody tr",:count => num_movies.to_i)
end

Then /^the director of "(.*)" should be "(.*)"$/ do |arg1, arg2|
  page.body =~ /#{arg1}.+Director.+#{arg2}/m
end