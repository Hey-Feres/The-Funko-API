require 'csv'
require 'open-uri'

class GetFunkoItems
  def initialize(url: 'https://www.funko.com/documents/wholesale-catalog.csv')
    @uri = url
  end

  def data_path
    URI.open(@uri)
  end

  def parsed_data
    JSON.parse(
      CSV.parse(
        File.read(data_path), headers: true
      ).to_json
    )
  end

  def headers
    parsed_data[0].map(&:parameterize)
  end

  def result
    puts 'Starting data fetch'

    filtered_data = []

    data = Rails.env.production? ? parsed_data[1..-1] : parsed_data[1..50]
    bar = ProgressBar.new(data.count)

    data.each do |d|
      x = {}
      headers.each_with_index do |k, i|
        x[k] = d[i]
      end
      filtered_data << x
      bar.increment!
    end

    filtered_data.to_json
  end
end
