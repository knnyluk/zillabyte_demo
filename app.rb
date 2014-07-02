# This is a template; feel free to change it.
# For more details, check out http://docs.zillabyte.com/quickstart/hello_world/

require 'zillabyte' 
require 'nokogiri'

Zillabyte.app("demos")
  .source("select * from web_pages")
  .each{ |page|
    if page['html'].include? "Request a Demo"
      emit(:url => page['url'], 
           :title_tag => Nokogiri::HTML(page['html']).css('title').text.strip)
    end
  }
  .sink{
    name "has_request_a_demo"
    column "url", :string
    column "title_tag", :string 
  }
