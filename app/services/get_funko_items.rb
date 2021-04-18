require 'csv'
require 'open-uri'
require 'yajl'

class GetFunkoItems
  def initialize(url: 'https://www.funko.com/documents/wholesale-catalog.csv')
    @uri = url
  end

  def data_path
    URI.open(@uri)
  end

  def json_data
    StringIO.new(CSV.parse(File.read(data_path), headers: true).to_json)
  end

  def headers
    parsed_data[0].map(&:parameterize)
  end

  def result
    puts 'Starting data fetch'

    parser = Yajl::Parser.new(symbolize_keys: true)
    parser.parse(json_data)[1..-1]
  end
end
