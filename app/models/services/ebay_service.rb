class EbayService

  def initialize
    @ebay = Ebay::Api.new(:site_id => 2)
  end

  def post_item(item)
    ebay_item = Ebay::Types::Item.new(
      primary_category: Ebay::Types::Category.new(category_id: item.category.ebay_categoryid),
      title: item.name,
      description: item.description,
      location: "Waterford, On",
      country: "CA",
      currency: "CAD",
      listing_duration: 'Days_14',
      shipping_details: Ebay::Types::ShippingDetails.new(
        shipping_service_options: [
          Ebay::Types::ShippingServiceOptions.new(
            shipping_service_priority: 2, # Display priority in the listing
            shipping_service: 'CA_PostRegularParcel',
            shipping_service_cost: Money.new(1000, 'CAD'),
            shipping_surcharge: Money.new(299, 'CAD')
           )
        ]
      )
    )
    begin
      response = @ebay.add_item(:item => ebay_item)
      puts "Adding item"
      puts "eBay time is: #{response.timestamp}"

      puts "Item ID: #{response.item_id}"
      puts "Fee summary: "
      response.fees.select{|f| !f.fee.zero? }.each do |f|
        puts "  #{f.name}: #{f.fee.format(:with_currency)}"
      end
    rescue Ebay::RequestError => e
      e.errors.each do |error|
        item.errors[:base] << error.long_message
      end
    end

    item.errors.any?
  end
end