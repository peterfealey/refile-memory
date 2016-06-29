require "refile/shopify"
require "refile/spec_helper"

RSpec.describe Refile::Shopify::Backend do
  let(:backend) { Refile::Shopify::Backend.new(max_size: 100) }

  it_behaves_like :backend
end

