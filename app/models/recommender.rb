class Recommender
  #
  # Modules
  #

  include Predictor::Base

  #
  # Matrixes
  #

  input_matrix :users,      weight: 4.0, measure: :sorensen_coefficient
  input_matrix :items,      weight: 3.0, measure: :sorensen_coefficient
  input_matrix :categories, weight: 2.0, measure: :sorensen_coefficient
  input_matrix :licenses,   weight: 2.0, measure: :sorensen_coefficient
  input_matrix :brands,     weight: 2.0, measure: :sorensen_coefficient
end

# Inputting Data
# recommender = Recommender.new
# recommender.items.add_to_set("Soldier Supreme", "Iron Hammer", "Diamond Patch", "Ghost Panther")
# recommender.process!
# time = Benchmark.measure do
#   recommender.process_items!("Soldier Supreme", "Iron Hammer", "Diamond Patch", "Ghost Panther")
# end
# puts time.total

# Retrieving Similarities and Recommendations
# recommender.similarities_for("Soldier Supreme")