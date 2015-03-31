require 'open-uri'
class CanadianWhScrapper < ActiveRecord::Base
  attr_accessible :category, :country, :page_content, :quota, :remaining, :status,
    :modified_page_date, :xml_content, :ip, :kompass_year, :kompass_modified_page_date

  PAGE_URL = "http://www.cic.gc.ca/english/work/iec/index.asp?country=cl&cat=wh"
  PAGE_XML = "http://www.cic.gc.ca/english/work/iec/data.xml"
  KOMPASS_URL = "http://kompass-2015-iec-eic.international.gc.ca/selectedregion-r%C3%A9gions%C3%A9lectionn%C3%A9e?regionCode=CL&Lang=eng"

  class << self

    def execute(ip = 'DIRECT CONSOLE REQUEST')
      @ip = ip
      unless (values = group_results).nil?
        values.merge!({ ip: @ip, country: 'Chile', category: 'Work And Holiday' })
        create(values.reject!{ |k| k == :error })
      end
    end

    private

      def group_results
        values = {}
        %w(cic_page cic_xml kompass_page).each do |method|
          results = send(method)
          if results[:error]
            values = nil
            break
          else
            values.merge!(results)
          end
        end
        values
      end

      def cic_page
        results = { error: true }
        begin
          page_doc = Nokogiri::HTML(open PAGE_URL)
          results = {
            page_content: page_doc.at_css('.container>.row>main').to_html,
            modified_page_date: page_doc.at_css('#wb-dtmd>dd>time').children.to_s.try(:to_date),
            error: false
          }
        rescue Exception => e
          Notification.create({ source: 'cic_page', message: e.message, ip: @ip })
        end
        results
      end

      def cic_xml
        results = { error: true }
        begin
          xml_doc = Nokogiri::XML(open PAGE_XML)
          chilean_wh = xml_doc.xpath("//country[@location='Chile'][@category='wh']")
          results = {
            quota: chilean_wh.xpath('quota').children.to_s.to_i,
            remaining: chilean_wh.xpath('places').children.to_s.to_i,
            status: chilean_wh.xpath('status').children.to_s,
            xml_content: chilean_wh.to_xml,
            error: false
          }
        rescue Exception => e
          Notification.create({ source: 'cic_xml', message: e.message, ip: @ip })
        end
        results
      end

      def kompass_page
        results = { error: true }
        begin
          kompass_doc = Nokogiri::XML(open KOMPASS_URL)
          results = {
            kompass_year: kompass_doc.css('.cic-module-ctn-inner').text.match(/Log.+?\d+/).to_s.match(/\d+/).to_s,
            kompass_modified_page_date: kompass_doc.at_css('#wb-dtmd time').text.try(:to_date),
            error: false
          }
        rescue Exception => e
          Notification.create({ source: 'kompass_page', message: e.message, ip: @ip })
        end
        results
      end

  end



end
