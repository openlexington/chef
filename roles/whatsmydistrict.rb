name 'whatsmydistrict'
description 'Installs Whats My District?'
run_list(
  'role[base-local]',
  'recipe[whatsmydistrict]'
)

override_attributes(
  postgresql: {
    password: {
      postgres: 'password'
    }
  },
  rbenv: {
    system_installs: {
      rubies: [ '1.9.3-p392' ]
    }
  },
  hostname: {
    set_fqdn: 'whatsmydistrict.org'
  }
)
