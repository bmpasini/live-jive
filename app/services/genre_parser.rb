require 'csv'
require 'pp'

class PGenre
  attr_reader :id
  attr_accessor :genre

  def initialize(args = {})
    @id = args[:id]
    @genre = args[:genre]
  end
end

class PSubgenre
  attr_reader :id
  attr_accessor :subgenre, :genre_id

  def initialize(args = {})
    @id = args[:id]
    @genre_id = args[:genre_id]
    @subgenre = args[:subgenre]
  end
end

class GenreParser
  attr_reader :file, :genre

  def initialize(file)
    @file = file
    @genre = nil
  end

  def genre
    return @genre if @genre
    @genre = Array.new
    CSV.foreach(file) do |row|
      row_hash = { id: row[0], genre: row[1] }
      @genre << PGenre.new(row_hash)
    end
    @genre
  end

end

class SubgenreParser
  attr_reader :file, :genre_id, :subgenre

  def initialize(file)
    @file = file
    @genre_id = nil
    @subgenre = nil
  end

  def subgenre
    return @subgenre if @subgenre
    @subgenre = Array.new
    CSV.foreach(file) do |row|
      row_hash = { id: row[0], genre_id: row[1], subgenre: row[2] }
      # puts row_hash
      @subgenre << PSubgenre.new(row_hash)
    end
    @subgenre
  end
end

class LiveJiveGenre
  attr_accessor :genre, :subgenre

  def initialize(args = {})
    @genres = args[:genres]
    @subgenres = args[:subgenres]
  end

  def self.clean_hashes
    clean_hashes = Array.new
    dirty_hashes.each do |dirty_hash|
      clean_hashes << remove_myspace(remove_general(equalize_if_nil(dirty_hash))) unless (dirty_hash[:genre] == nil && dirty_hash[:subgenre] == nil)
    end
    clean_hashes
  end

  private
    def self.equalize_if_nil(entry)
      puts g = entry[:genre]
      puts s = entry[:subgenre]
      s = g unless s
      g = s unless g
      { genre: g, subgenre: s}
    end

    def self.remove_general(entry)
      g = entry[:genre]
      s = entry[:subgenre]
      g.slice! " - general" if g.include? " - general"
      s.slice! " - general" if s.include? " - general"
      { genre: g, subgenre: s}

    end

    def self.remove_myspace(entry)
      g = entry[:genre]
      s = entry[:subgenre]
      g.slice! "http://www.myspace.com/" if g.include? "http://www.myspace.com/"
      s.slice! "http://www.myspace.com/" if s.include? "http://www.myspace.com/"
      { genre: g, subgenre: s}
    end

    def self.dirty_hashes
      get_genres_and_subgenres
      genre_hashes = Array.new
      @subgenres.subgenre.each do |subgenre|
        # puts subgenre.subgenre
        genre_hash = { genre: genre_name(subgenre.genre_id), subgenre: subgenre.subgenre }
        genre_hashes << genre_hash
      end
      genre_hashes.shift
      genre_hashes
    end

    def self.get_genres_and_subgenres
      @genres = GenreParser.new('app/services/genre.csv')
      @subgenres = SubgenreParser.new('app/services/subgenre.csv')
    end

    def self.genre_name(id)
    @genres.genre.each do |genre|
      return genre.genre if genre.id == id
    end
    nil
  end
end

genre_parser = GenreParser.new('app/services/genre.csv')
subgenre_parser = SubgenreParser.new('app/services/subgenre.csv')

# genres = genre_parser.genre
# subgenres = subgenre_parser.subgenre

pp LiveJiveGenre.clean_hashes



