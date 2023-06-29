class Webhok < ApplicationRecord
  #  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
    validates :url, :secret, presence: true
  validates :url, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
end
