class SeedDatabase
  def initialize
    new_data_fetch     = GetFunkoItems.new.result

    @new_data_fetch    = JSON.parse(new_data_fetch)
    @last_data_fetched = DataFetch.all&.last&.data
  end

  def should_seed_database?
    return true if @last_data_fetched.nil?

    @new_data_fetch != @last_data_fetched
  end

  def data
    return unless should_seed_database?

    # Get the diff bewteen the data that already been fetched
    # and the new one.
    @last_data_fetched ? @new_data_fetch - @last_data_fetched : @new_data_fetch
  end

  def seed_categories
    categories = data.map{|data| data['category']}.uniq
    categories.delete(nil)
    categories = categories.map{|data| data.split(',')}.flatten.uniq

    categories.each do |category|
      Category.find_or_create_by(name: category)
    end
  end

  def seed_events
    events = data.map{ |data| data['events'] }.uniq
    events.delete(nil)
    events = events.map{|data| data.split(',')}.flatten.uniq

    events.each do |event|
      Event.find_or_create_by(name: event)
    end
  end

  def seed_licenses
    licenses = data.map{ |data| data['license'] }.uniq
    licenses.delete(nil)
    licenses = licenses.map{|data| data.split(',')}.flatten.uniq

    licenses.each do |license|
      License.find_or_create_by(name: license)
    end
  end

  def seed_brands
    brands = data.map{ |data| data['brand'] }.uniq
    brands.delete(nil)
    brands = brands.map{|data| data.split(',')}.flatten.uniq

    brands.each do |brand|
      Brand.find_or_create_by(name: brand)
    end
  end

  def seed_features
    features = data.map{ |data| data['features'] }.uniq
    features.delete(nil)
    features = features.map{|data| data.split(',')}.flatten.uniq

    features.each do |feature|
      Feature.find_or_create_by(name: feature)
    end
  end

  def seed_items
    data[0..-1].each do |data|
      item = Item.new(
        number: data['item-number'],
        title: data['title'],
        form_factor: data['form-factor'],
        inner_case_count: data['inner-case-count'],
        master_case_quantity: data['master-case-quantity'],
        status: data['status'],
        image_url: data['image-url']
      )

      item.category = Category.find_by(name: data['category']) if data['category'].present?
      item.license  = License.find_by(name: data['license']) if data['license'].present?
      item.brand    = Brand.find_by(name: data['brand']) if data['brand'].present?

      if data['events'].present?
        data['events'].split(',').each do |event_name|
          event = Event.find_by(name: event_name)

          if event.present?
            item.events << event if item.events.map(&:id).exclude?(event.id)
          end
        end
      end

      if data['features'].present?
        data['features'].split(',').each do |feature_name|
          feature = Feature.find_by(name: feature_name)

          if feature.present?
            item.features << feature if item.features.map(&:id).exclude?(feature.id)
          end
        end
      end

      item.save!
    end
  end

  def call
    seed_categories
    seed_events
    seed_licenses
    seed_brands
    seed_features
    seed_items

    DataFetch.create!(data: data, fetched_at: DateTime.now)
  end
end
