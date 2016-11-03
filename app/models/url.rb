class Url < ActiveRecord::Base
validates :long_url, presence: true, uniqueness: true
validates :long_url, :format => { :with => URI::regexp(%w(http https)), :message => "Valid URL required"}

  before_create :create_url_short

  def create_url_short
    if self.long_url != nil
      uri = URI.parse(self.long_url)
      var = []
      6.times{ rand(0..1) == 1 ? var << rand(97..122).chr : var << rand(0..9) }
      self.short_url = "#{uri.scheme}://cow.lo/#{var.join}"
    end
  end
end