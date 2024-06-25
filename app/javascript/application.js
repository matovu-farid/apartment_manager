// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require select2
$(document).on('turbolinks:load', function () {
  $('.datepicker').datepicker();
});

