# Be sure to restart your server when you modify this file.
# Add new inflection rules using the following format. Inflections are locale specific, and you may define rules for as many different locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  # inflect.plural /^(ox)$/i, '\1en'
  # inflect.singular /^(ox)en/i, '\1'
  # inflect.irregular 'fanship', 'fanships'
  inflect.irregular 'band_plays_genre', 'band_plays_genres'
  inflect.irregular 'BandPlaysGenre', 'BandPlaysGenres'
  inflect.uncountable %w( fanships )
  inflect.uncountable %w( tickets )
  inflect.uncountable %w( ConcertGoings )
  inflect.uncountable %w( concert_goings )
end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
