require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '/',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/task', WEBrick::HTTPServlet::ERBHandler, 'task.html.erb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
# <form action='goya2.cgi'> 〜 </form>の内部にある値を、goya2.rbに送信できるようにする
server.mount('/goya2.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya2.rb')
server.start
