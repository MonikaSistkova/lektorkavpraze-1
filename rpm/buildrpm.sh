#!/bin/bash
set -x
cd `dirname $0`
cd ..

mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

VERSION=`date -u +%Y%m%d%H%M`
cp rpm/lektorkavpraze.spec ~/rpmbuild/SPECS/
sed -i "s/-VERSION-/$VERSION/g" ~/rpmbuild/SPECS/lektorkavpraze.spec

rm ~/rpmbuild/SOURCES/lektorkavpraze.tar.gz
mkdir ~/rpmbuild/SOURCES/lektorkavpraze-1
cp -r www rb systemd nginx ~/rpmbuild/SOURCES/lektorkavpraze-1/
( cd ~/rpmbuild/SOURCES/; tar cvzf lektorkavpraze.tar.gz lektorkavpraze-1 )
rm -r ~/rpmbuild/SOURCES/lektorkavpraze-1

rpmbuild -bb -v ~/rpmbuild/SPECS/lektorkavpraze.spec

rm rpm/*.rpm
cp ~/rpmbuild/RPMS/noarch/*.rpm rpm/
