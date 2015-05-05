namespace :scrapper do

  def run_wh_scrapper
    puts ">> Running BG Scrapper ...\n".green_on_blue
    CanadianWhScrapper.execute('BG RAKE REQUEST')
  end

end
