# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin('application')
pin('@hotwired/turbo-rails', to: 'turbo.min.js')
pin('@hotwired/stimulus', to: 'stimulus.min.js')
pin('@hotwired/stimulus-loading', to: 'stimulus-loading.js')
pin('bootstrap', to: 'bootstrap.min.js', preload: true)
pin('@popperjs/core', to: 'popper.js', preload: true)
pin_all_from('app/javascript/controllers', under: 'controllers')
pin "tom-select" # @2.4.1
pin "@orchidjs/sifter", to: "@orchidjs--sifter.js" # @1.1.0
pin "@orchidjs/unicode-variants", to: "@orchidjs--unicode-variants.js" # @1.1.2
