name 'base'
description 'Base role applied to all nodes.'
run_list(
  'recipe[annoyances]',
  'recipe[apt]',
  'recipe[build-essential]',
  'recipe[hostname]'
)
override_attributes(
  build_essential: {
    compiletime: true
  }
)
