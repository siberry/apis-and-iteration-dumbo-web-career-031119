require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  #return the character hash from API
  character_hash = response_hash["results"].find do |character_hash|
    character_hash["name"] == character_name
  end
  #return array of hashes of movie info
  character_movies_hash = character_hash["films"].map do |url|
    url_response_string = RestClient.get(url)
    JSON.parse(url_response_string)
  end
end


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  film_titles = films.map do |x|
    "⚡️"+x["title"].yellow
  end
  puts film_titles
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
