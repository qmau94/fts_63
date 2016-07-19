// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function addForm() {
  var association = 'answers';
  var regexp = new RegExp('new_' + association, 'g');
  var new_id = new Date().getTime();
  $('.add_answer').before(window[association + '_field'].
    replace(regexp, new_id));
  $('.correct-choose').hide();
  $('.remove-choose').hide();
  $('.add_answer').hide();
}

function changeType() {
  var options = $('.field');
  for(i = 0; i < options.length; i++){
    $(options[i].querySelector('.remove-choose > a')).
      prev('input[type=hidden]').val('1');
    $(options[i].querySelector('.remove-choose > a')).addClass('hidden');
  }
  options.addClass('hidden');
}
var prev;
$(document).on('focus', '.question-type', function() {
  prev = this.value;
});

$(document).on('change load', '.question-type', function() {
   if($(this).val() == 'single_choice') {
    changeType();
    $('.add_answer').show();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', false);
    })
    if(prev == 'text'){
      changeType();
    }
  } else if ($(this).val() == 'multiple_choice') {
    changeType();
    $('.add_answer').show();
    if(prev == 'text'){
      changeType();
    }
  } else if($(this).val() == 'text') {
    var x = $(this).val();
    changeType();
    addForm();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', true);
    })
  }
  prev = $(this).val();
});

function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('.field').hide();
}

var remove = function(){
  $('.td-question form').on('click', '.add_field', function(){
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
  });
};

$(document).on("page:change", remove);

var add = function() {
  $('form').on('click', '.remove_fields', function(event) {
    $(this).closest('.field').remove();
    return event.preventDefault();
  });
  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });
};

$(document).on("page:change", add);
