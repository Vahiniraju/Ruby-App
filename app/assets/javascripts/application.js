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

//= require jquery3
//= require rails-ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

//When an answer is selected - add green to background color
$(document).on('change', 'input:radio[name="user_selection[answer_id]"]', function(){
    $('label.form-control').css('background-color', '#F7F7F7');
    if ($(this).is(':checked')) {
        $(this).closest('label').css('background-color', '#15ff1c');
    }
});
