class CanadianWhScrapper < ActiveRecord::Base
  attr_accessible :category, :country, :page_content, :quota, :remaining, :status, :modified_page_date, :xml_content, :ip

  PAGE_URL = "http://www.cic.gc.ca/english/work/iec/index.asp"
  PAGE_XML = "http://www.cic.gc.ca/english/work/iec/data.xml"

  def self.execute(ip = 'DIRECT CONSOLE REQUEST')
    require 'open-uri'
    xml_doc = Nokogiri::XML(open PAGE_XML)
    page_doc = Nokogiri::HTML(open PAGE_URL)
    chilean_wh = xml_doc.xpath("//country[@location='Chile'][@category='wh']")
    values = {
      ip: ip,
      country: 'Chile',
      category: 'Work And Holiday',
      quota: chilean_wh.xpath('quota').children.to_s.to_i,
      remaining: chilean_wh.xpath('places').children.to_s.to_i,
      status: chilean_wh.xpath('status').children.to_s,
      page_content: page_doc.at_css('.reCorporate').to_html,
      xml_content: chilean_wh.to_xml,
      modified_page_date: page_doc.at_css('#wb-dtmd>dd>time').children.to_s.try(:to_date)
    }

    self.create(values)
  end

end
