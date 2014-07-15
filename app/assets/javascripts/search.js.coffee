# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Search
        constructor: ->
                $('#search-form').on('click', 'a.submit', (event) =>
                        event.preventDefault();
                        $('#search-form').submit()
                        );
        

jQuery ->
        search = new Search();

