#
# spec file for package lektorkavpraze
#
# Copyright (c) 2017 Vaclav Sistek
#

Name:           lektorkavpraze
Version:	1
Release:	-VERSION-
Vendor:		Vaclav Sistek
License:	GPLv3
Summary:	lektorkavpraze.cz website
Url:		http://www.lektorkavpraze.cz/
Group:		Unspecified
Source:		lektorkavpraze.tar.gz
BuildArch:	noarch
BuildRoot:      %{_tmppath}/%{name}-%{version}-build
Requires:	nginx ruby

%description
lektorkavpraze.cz website files, sinatra app, systemd service, nginx configuration

%prep
%setup -q

%build


%install
rm -rf %{buildroot}

install -d	%{buildroot}/srv/www/lektorkavpraze.cz
install -d	%{buildroot}/srv/www/lektorkavpraze.cz/www
install -m 644	www/kontakt.html %{buildroot}/srv/www/lektorkavpraze.cz/www/kontakt.html
install -m 644	www/omne.html %{buildroot}/srv/www/lektorkavpraze.cz/www/omne.html
install -m 644	www/piano.html %{buildroot}/srv/www/lektorkavpraze.cz/www/piano.html
install -m 644	www/anglictina.html %{buildroot}/srv/www/lektorkavpraze.cz/www/anglictina.html
install -m 644	www/doucovani.html %{buildroot}/srv/www/lektorkavpraze.cz/www/doucovani.html
install -d	%{buildroot}/srv/www/lektorkavpraze.cz/www/resources
install -d	%{buildroot}/srv/www/lektorkavpraze.cz/www/resources/js
install -m 644  www/resources/js/jquery.js %{buildroot}/srv/www/lektorkavpraze.cz/www/resources/js/jquery.js
install -d	%{buildroot}/srv/www/lektorkavpraze.cz/www/resources/css
install -m 644	www/resources/css/main.css %{buildroot}/srv/www/lektorkavpraze.cz/www/resources/css/main.css
install -d	%{buildroot}/srv/www/lektorkavpraze.cz/www/resources/images
install -m 644	www/resources/images/favicon-ms.png %{buildroot}/srv/www/lektorkavpraze.cz/www/resources/images/favicon-ms.png
install -m 644	www/resources/images/pokoj.jpg %{buildroot}/srv/www/lektorkavpraze.cz/www/resources/images/pokoj.jpg
install -m 644	www/resources/images/pokoj-modrany.jpg %{buildroot}/srv/www/lektorkavpraze.cz/www/resources/images/pokoj-modrany.jpg
install -m 644	www/resources/images/MS.png %{buildroot}/srv/www/lektorkavpraze.cz/www/resources/images/MS.png
install -d	%{buildroot}/srv/www/lektorkavpraze.cz/rb
install -m 644	rb/lektorkavpraze.rb %{buildroot}/srv/www/lektorkavpraze.cz/rb/lektorkavpraze.rb
install -d	%{buildroot}/etc/nginx/vhosts.d
install -m 644	nginx/lektorkavpraze.cz.conf %{buildroot}/etc/nginx/vhosts.d/lektorkavpraze.cz.conf
install -d	%{buildroot}/etc/systemd/system
install -m 644	systemd/lektorkavpraze.service %{buildroot}/etc/systemd/system/lektorkavpraze.service

%post
echo Installing rubygems
/usr/bin/gem install sinatra
/usr/bin/gem install pony

echo starting and enabling systemd service
/usr/bin/systemctl daemon-reload
/usr/bin/systemctl start lektorkavpraze
/usr/bin/systemctl enable lektorkavpraze

echo Reloading nginx.
/usr/bin/systemctl reload nginx

%files
%dir /srv/www/lektorkavpraze.cz
%dir /srv/www/lektorkavpraze.cz/www
%dir /srv/www/lektorkavpraze.cz/www/resources
%dir /srv/www/lektorkavpraze.cz/www/resources/js
%dir /srv/www/lektorkavpraze.cz/www/resources/css
%dir /srv/www/lektorkavpraze.cz/www/resources/images
%dir /srv/www/lektorkavpraze.cz/rb
%defattr(-,root,root)
/srv/www/lektorkavpraze.cz/www/kontakt.html
/srv/www/lektorkavpraze.cz/www/omne.html
/srv/www/lektorkavpraze.cz/www/piano.html
/srv/www/lektorkavpraze.cz/www/anglictina.html
/srv/www/lektorkavpraze.cz/www/doucovani.html
/srv/www/lektorkavpraze.cz/www/resources/js/jquery.js
/srv/www/lektorkavpraze.cz/www/resources/css/main.css
/srv/www/lektorkavpraze.cz/www/resources/images/favicon-ms.png
/srv/www/lektorkavpraze.cz/www/resources/images/pokoj.jpg
/srv/www/lektorkavpraze.cz/www/resources/images/pokoj-modrany.jpg
/srv/www/lektorkavpraze.cz/www/resources/images/MS.png
/srv/www/lektorkavpraze.cz/rb/lektorkavpraze.rb
/etc/nginx/vhosts.d/lektorkavpraze.cz.conf
/etc/systemd/system/lektorkavpraze.service
