class ScrapperController < ActionController::Base
  layout 'scrapper'

  def iec
    @iec_wh = CanadianWhScrapper.last
    @reference = CanadianWhScrapper::PAGE_URL
    @kompass_reference = CanadianWhScrapper::KOMPASS_URL
  end

  def iec_request
    forced = params['force'] == '1'
    old_date = CanadianWhScrapper.last.try(:created_at) || 2.hours.ago
    enough_time = ((old_date - Time.now) / 1.hour).round < 0
    CanadianWhScrapper.execute(request.ip) if enough_time || forced

    redirect_to action: :iec
  end

end