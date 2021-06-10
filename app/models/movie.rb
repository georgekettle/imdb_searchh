class Movie < ApplicationRecord
  belongs_to :director

  searchkick

  # include the relevant methods from PgSearch::Model
  include PgSearch::Model
  # multi search
  multisearchable against: [:title, :synopsis]

  # single model search
  pg_search_scope :global_search,
    against: [ :title, :synopsis ],
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
