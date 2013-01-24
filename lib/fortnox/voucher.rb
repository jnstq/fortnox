module Fortnox
  class Voucher < API
    class << self
      def create(attributes={})
        response = run :post, :set_voucher, with_root(attributes)
        response['result'] ? response['result']['id'].to_i : false
      end

      private

      def with_root(attributes)
        { :voucher => attributes }
      end
    end
  end
end
