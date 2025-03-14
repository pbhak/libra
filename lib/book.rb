require 'net/http'
require 'json'
require 'uri'

module Book
  # This is a bit odd, so I'll put a bit of an explanation of what it does here
  # The make_request function is self explanatory, it makes an HTTP request and returns a request object
  # However, the OpenLibrary /isbn/[isbn] endpoint does not return the data, it instead redirects
  # to a page that contains the data
  # Because of this, you need to first make a request to /isbn/[isbn], then make another request
  # to the given URL to redirect
  # The data is then parsed from JSON into a Ruby Hash object and subsequently returned
  # If you somehow got here and are reading this, send me a message because you're a real one :)

  def make_request(url)
    url = URI(url)
  
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    
    http.request(Net::HTTP::Get.new(url))
  end

  def book_info(isbn)
    response = make_request(make_request("https://openlibrary.org/isbn/#{isbn}.json")['location'])

    p JSON.parse(response.read_body)
  end
end
