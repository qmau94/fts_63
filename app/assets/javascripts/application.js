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
//= require jquery.countdown
//= require countdown
//= require i18n/translations
//= require social-share-button
//= require_tree .

/* jquery change type question */
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
};

var prev;
$(document).on('focus', '.question-type', function() {
  prev = this.value;
});

  /* jquery create question */
$(document).on('change load', '.td-q-e-1 .question-type', function() {
  if($(this).val() == 'single_choice') {
    $('input[type="checkbox"]').prop('checked', false);
    checkbox();
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
    $('input[type="checkbox"]').prop('checked', false);
    changeType();
    $('.add_answer').show();
    if(prev == 'text'){
      changeType();
    }
  } else if($(this).val() == 'text') {
    var x = $(this).val();
    changeType();
    addForm();
    $('.correct-choose').hide();
    $('.remove-choose').hide();
    $('.add_answer').hide();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', true);
    })
  }
  prev = $(this).val();
});
  /* finish jquery create question */

  /* jquery update question */
$(document).on('change load', '.td-q-e-2 .question-type', function() {
  if($(this).val() == 'single_choice') {
    $('input[type="checkbox"]').prop('checked', false);
    $('.add_answer').show();
    var allCheckboxs = $('.correct');
    allCheckboxs.each(function(index, cb) {
      $(cb).attr('checked', false);
    });
    if(prev == 'text'){
      changeType();
    }
  } else if ($(this).val() == 'multiple_choice') {
    $('input[type="checkbox"]').prop('checked', false);
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
  /* finish jquery update question */

function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('.field').hide();
}

function checkbox() {
  var type = $('.question-type').val();
  if(type == 'single_choice'){
    $('input[type="checkbox"]').on('click', function() {
      $('input[type="checkbox"]').not(this).prop('checked', false);
    })
  }
};

var remove = function(){
  $('.td-question form').on('click', '.add_field', function(){
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    event.preventDefault();
    checkbox();
  });
};

$(document).on('page:change', remove);

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
    checkbox();
  });
};

$(document).on('page:change', add);
/* finish jquery change type question */


var dropdown = function(){
  var x = 1;
  $('.treeview a').on('click', function(){
    if(x == 1){
      $('.treeview-menu').slideDown(300,function(){
        $('.treeview-menu li').fadeIn(100);
      });
      x = 0;
    }
    else{
      $('.treeview-menu').slideUp(300,function(){
        $('.treeview-menu li').fadeOut(100);
      });
      x = 1;
    }
  });
  
};
$(document).on('page:change', dropdown);

var flash = function(){
  setTimeout(function(){
    $('.alert').slideUp(500);
  }, 2000);
  var x = $(window).height();
  var y = x - 60;
  $('.content').css('min-height', x);
  $('.page-content').css('min-height', x);
  $('.signin').css('min-height', y);
};

$(document).ready(flash);
$(document).on('page:load', flash);
$(document).on('page:change', flash);

var scroll_top = function(){
  $('.circle img').click(function() {
    $('html, body').animate({ scrollTop: 0 }, 'slow');
    return false;
  });
  $(window).scroll(function() {
    var scroll = $(window).scrollTop();
    if(scroll >= 10){
      $('.circle').addClass('block');
      $('.header').addClass('header-hover');
      $('#logo').removeClass('block');
      $('#logo').addClass('none');
      $('#logo-before').removeClass('none');
      $('#logo-before').addClass('block');
    }
    else{
      $('.circle').removeClass('block');
      $('.header').removeClass('header-hover');
      $('#logo-before').removeClass('block');
      $('#logo-before').addClass('none');
      $('#logo').removeClass('none');
      $('#logo').addClass('block');
    }
  });
};
$(document).ready(scroll_top);
$(document).on('page:load', scroll_top);
$(document).on('page:change', scroll_top);

var check_single = function() {
  var type = $('.question-type').val();
  if(type == 'single_choice'){
    $('input[type="checkbox"]').on('click', function() {
      $('input[type="checkbox"]').not(this).prop('checked', false);
    })
  }
  else if(type == 'text'){
    $('.correct-choose').hide();
    $('.remove-choose').hide();
    $('.add_answer').hide();
  }
};

$(document).on('change', check_single);
