# https://www.funko.com/documents/wholesale-catalog.csv
# json = URI.open('https://raw.githubusercontent.com/kennymkchan/funko-pop-data/master/funko_pop.json')
# data = JSON.load(File.open(json))
# # agent = Mechanize.new
# # # agent.pluggable_parser.default = Mechanize::Page
# # url = 'https://www.funko.com'
# # # # 'https://www.funko.com/shop-dc-comics'
# # page = agent.get(url)
# # # https://www.funko.com/api/search/shop/collection/163594600514
# # # page.search('div.commerce-products-list-item')
# # File.open("public/pop_data.json","w") do |f|
# #   f.write(data.to_json)
# # end
# require 'csv'
# csv = URI.open('https://www.funko.com/documents/wholesale-catalog.csv')
# data = CSV.parse(File.read(csv), headers: true)
# data = data.to_json
# data = JSON.parse(data)

# headers = data.first.map(&:parameterize)
# filtered_data = []

# data[1..-1].each do |data|
#   x = {}
#   headers.each_with_index do |k, i|
#     x[k] = data[i]
#   end
#   filtered_data << x
# end

# File.open("public/official_pop_data.json","w") do |f|
#   f.write(filtered_data.to_json)
# end
