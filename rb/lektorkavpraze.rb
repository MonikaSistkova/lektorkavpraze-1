# encoding: UTF-8

require 'yaml'
require 'rubygems'
require 'sinatra'
require 'pony'

set :bind,      "localhost"
set :port,      2011
set :protection, :origin_whitelist => ['http://www.lektorkavpraze.cz']

$config = YAML.load_file('/etc/lektorkavpraze.conf')

get '/' do
  erb :kontakt
end

post '/odeslat' do
  @message = params[:message]
  sendmail(@message[:name], @message[:contact],  @message[:body])
  erb :kontaktodeslat
end

not_found do
  redirect '/404.html'
end

error do
  redirect '/500.html'
end

private

def sendmail(name, contact, body)
  Pony.mail :to => 'monika.sistkova@gmail.com',
            :from => 'noreply@sistkovi.cz',
            :subject => "Zpráva z webu lektorkavpraze.cz od: #{name} / #{contact}",
            :body => body,
            :via => :smtp,
            :via_options => {
              :address => 'smtp.gmail.com',
              :port => '587',
              :enable_starttls_auto => true,
              :user_name => $config["gmail_user"],
              :password => $config["gmail_pass"],
              :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
              :domain => "localhost.localdomain" # the HELO domain provided by the client to the server
            }
end

__END__
@@ kontakt
<form action="/odeslat" method="post" id="contactform">
<table>
<tr><td style="text-align:right">Jméno</td><td style="text-align:left"><input type="text" size="60" name="message[name]" /></td></tr>
<tr><td style="text-align:right">Kontakt (email, telefon)</td><td style="text-align:left"><input type="text" size="60" name="message[contact]" /></td></tr>
<tr><td style="text-align:right; vertical-align:top;">Vzkaz</td><td><textarea cols="60" rows="15" name="message[body]"></textarea></td></tr>
<tr><td colspan="2" style="text-align:right"><button type="submit">Odeslat</button></td></tr>
</table>
</form>

@@ kontaktodeslat
<p id="justify">Zpráva byla odeslána. Pokud v ní byl uveden zpětný kontakt, pokusím se ozvat zpět v nejbližším možném termínu. Děkuji.</p>
<p><a href="/">Odelsat další zprávu</a></p>

@@ layout
<!doctype html>
<html lang="cs">
<head>
  <meta charset="utf-8">
  <title>Monika Šístková - lektorka - angličtina, hra na piano, doučování</title>
  <meta name="description" content="Monika Šístková - ektorka - angličtina, hra na piano, doučování">
  <meta name="author" content="Vaclav Sistek">
  <link rel="stylesheet" href="/resources/css/main.css">
  <link href="/resources/images/favicon-ms.png" rel="icon" type="image/png" />
  <link href='http://fonts.googleapis.com/css?family=Racing+Sans+One&subset=latin,latin-ext' rel='stylesheet' type='text/css'>
  <!--[if lt IE 9]>
  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
  <![endif]-->
  <script type="text/javascript" src="/resources/js/jquery.js"></script>
  <script>
$(document).ready(function(){
$('#tabs div').hide();
$('#tabs div:first').show();
$('#tabs ul li:first').addClass('active');
 
$('#tabs ul li a').click(function(){
$('#tabs ul li').removeClass('active');
$(this).parent().addClass('active');
var currentTab = $(this).attr('href');
$('#tabs div').hide();
$(currentTab).show();
return false;
});
});
  </script> 
</head>
<body>
<div id="centerbox">
<h1 id="title">Monika Šístková,</h1>
<h2 id="subtitle">lektorka</h2>
<div id="content">
<div id="tabs">
  <ul id="tabtops">
    <li><a href="#omne">O mně</a></li>
    <li><a href="#anglictina">Angličtina</a></li>
    <li><a href="#piano">Hra na piano</a></li>
    <li><a href="#doucovani">Doučování</a></li>
  </ul>
  <div id="omne">
    <%= IO.read("/srv/www/lektorkavpraze.cz/www/omne.html") %>
  </div>
  <div id="anglictina">
    <%= IO.read("/srv/www/lektorkavpraze.cz/www/anglictina.html") %>
    <p><%= $config["cena_anglictina"] %><br/></p>
  </div>
  <div id="piano">
    <%= IO.read("/srv/www/lektorkavpraze.cz/www/piano.html") %>
    <p><%= $config["cena_piano"] %><br/></p>
  </div>
  <div id="doucovani">
    <%= IO.read("/srv/www/lektorkavpraze.cz/www/doucovani.html") %>
    <p><%= $config["cena_doucovani"] %><br/></p>
  </div>
</div>
<h3>Kontakt</h3>
<%= IO.read("/srv/www/lektorkavpraze.cz/www/kontakt.html") %>
<%= yield %>
</div>
<div id="bgtitle">Foto učebny</div>
</body>
</html>
