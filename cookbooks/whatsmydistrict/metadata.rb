name             'whatsmydistrict'
maintainer       'OpenLexington'
maintainer_email 'lexington@codeforamerica.org'
license          'Apache 2.0'
description      'Installs/Configures whatsmydistrict'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt'
depends 'git'
depends 'nginx'
depends 'postgis'
