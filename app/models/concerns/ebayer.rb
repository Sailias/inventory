require 'active_support/concern'

module Ebayer
  extend ActiveSupport::Concern

  included do

    def post_to_ebay
      ebay_service = EbayService.new
      ebay_service.post_item(self)
    end

  end
end