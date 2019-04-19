// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require bootstrap-sprockets
//= require activestorage
//= require jquery

//= require bootstrap-sprockets
//= require jquery.raty
//= require ratyrate

//= require typeahead.js.js
//= require turbolinks
//= require jquery.easy-autocomplete
//= require_tree .

$(document).on('turbolinks:load', function(){
    var movies = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      remote: {
        url: '/movies/autocomplete?query=%QUERY',
        wildcard: '%QUERY'
      }
    });
    $('#movies_search').typeahead(null, {
      source: movies
    });
  })