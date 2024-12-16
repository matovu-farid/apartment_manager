// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require select2
//= require fontawesome/all
FontAwesome.config.mutateApproach = "sync";
$(document).on("turbolinks:load", function () {
  $(".datepicker").datepicker();
});
//var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
//var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
//  return new Popover(popoverTriggerEl)
//})
//var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
//var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
//  return new bootstrap.Tooltip(tooltipTriggerEl)
//})
//
