class SeedDatabase
  def initialize
    @new_data_fetch    = GetFunkoItems.new.result
    @last_data_fetched = DataFetch.all&.last&.data
  end

  def should_seed_database?
    return true if @last_data_fetched.nil?

    @new_data_fetch != @last_data_fetched
  end

  def data
    return unless should_seed_database?

    # Get the diff bewteen the data that already been fetched and the new one.
    @last_data_fetched ? @new_data_fetch - @last_data_fetched : @new_data_fetch
  end

  def filter_categories(object); object[5] end

  def filter_events(object); object[9] end

  def filter_licenses(object); object[4] end

  def filter_brands(object); object[6] end

  def filter_features(object); object[8] end

  def seed_categories
    categories_data = data.map{|data| filter_categories(data)}.uniq
    categories_data.delete(nil)
    categories_data = categories_data.map{|data| data.split(',')}.flatten.uniq
    categories = []

    categories_data.each do |category_name|
      category = Category.find_or_initialize_by(name: category_name)
      categories << category if category.new_record?
    end

    Category.import(categories)
  end

  def seed_events
    events_data = data.map{|data| filter_events(data)}.uniq
    events_data.delete(nil)
    events_data = events_data.map{|data| data.split(',')}.flatten.uniq
    events = []

    events_data.each do |event_name|
      event = Event.find_or_initialize_by(name: event_name)
      events << event if event.new_record?
    end

    Event.import(events)
  end

  def seed_licenses
    licenses_data = data.map{|data| filter_licenses(data)}.uniq
    licenses_data.delete(nil)
    licenses_data = licenses_data.map{|data| data.split(',')}.flatten.uniq
    licenses = []

    licenses_data.each do |license_name|
      license = License.find_or_initialize_by(name: license_name)
      licenses << license if license.new_record?
    end

    License.import(licenses)
  end

  def seed_brands
    brands_data = data.map{ |data| filter_brands(data)}.uniq
    brands_data.delete(nil)
    brands_data = brands_data.map{|data| data.split(',')}.flatten.uniq
    brands = []

    brands_data.each do |brand_name|
      brand = Brand.find_or_initialize_by(name: brand_name)
      brands << brand if brand.new_record?
    end

    Brand.import(brands)
  end

  def seed_features
    features_data = data.map{ |data| filter_features(data) }.uniq
    features_data.delete(nil)
    features_data = features_data.map{|data| data.split(',')}.flatten.uniq
    features = []

    features_data.each do |feature_name|
      feature = Feature.find_or_initialize_by(name: feature_name)
      features << feature if feature.new_record?
    end

    Feature.import(features)
  end

  def seed_items
    items = []

    data[0..-1].each do |data_item|
      item = Item.new(
        number: data_item[1],
        title: data_item[3],
        form_factor: data_item[7],
        inner_case_count: data_item[10],
        master_case_quantity: data_item[11],
        status: data_item[12],
        image_url: data_item[13]
      )

      category_name = filter_categories(data_item)
      license_name = filter_licenses(data_item)
      brand_name = filter_brands(data_item)

      item.category = Category.find_by(name: category_name) if category_name.present?
      item.license  = License.find_by(name: license_name) if license_name.present?
      item.brand    = Brand.find_by(name: brand_name) if brand_name.present?

      event_names = filter_events(data_item)

      if event_names.present?
        event_names.split(',').each do |event_name|
          event = Event.find_by(name: event_name)

          if event.present?
            item.events << event if item.events.map(&:id).exclude?(event.id)
          end
        end
      end

      feature_names = filter_features(data_item)

      if feature_names.present?
        feature_names.split(',').each do |feature_name|
          feature = Feature.find_by(name: feature_name)

          if feature.present?
            item.features << feature if item.features.map(&:id).exclude?(feature.id)
          end
        end
      end

      items << item
    end

    Item.import(items)
  end

  def call
    time = Benchmark.measure do
      seed_categories
      seed_events
      seed_licenses
      seed_brands
      seed_features
      seed_items

      DataFetch.create!(data: data, fetched_at: DateTime.now)
    end
    puts "Finished in #{time} seconds"
  end
end
