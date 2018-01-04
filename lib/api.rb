require 'net/http'
require 'json'


class Top5
  
  def self.getImdbIds
    imdbIdElement = 4 #strip the imDb ID from the movie's url
                      #(Haven't figured out any other way of doing it)
    imdbIdArray = []
    File.open("lib/top5ImdbVids.txt").readlines.each do |line|
      vid = line.split('/')
      imdbIdArray << vid[imdbIdElement]
    end
    return imdbIdArray
  end
  
  def self.movieData
    top5 = []
    getImdbIds.each do |id|
      apiTag = "http://www.omdbapi.com/?i=#{id}&apikey=da4134f5"
      apiData = JSON.parse(Net::HTTP.get(URI(apiTag)))
      
      top5Hash = {title:       apiData["Title"].to_s,
                  content:     apiData["Rated"].to_s,
                  description: apiData["Plot"].to_s,
                  actors:      apiData["Actors"].to_s,
                  released:    apiData["Released"].to_s,
                  genre:       apiData["Genre"].to_s,
                  imdbId:      apiData["imdbID"].to_s,
                  stars:       apiData["imdbRating"].to_s,
                  thumbnail:   apiData["Poster"].to_s}
      
      top5 << top5Hash
    end
    return top5
  end  
end
