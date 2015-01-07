class ScrapperController < ActionController::Base
  layout 'scrapper'

  def iec
    @iec_wh = CanadianWhScrapper.last
    @reference = CanadianWhScrapper::PAGE_URL
  end

end