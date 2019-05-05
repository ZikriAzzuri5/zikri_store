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
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require_tree .

const formatter = new Intl.NumberFormat('id-ID', {
  style: 'currency',
  currency: 'IDR',
  minimumFractionDigits: 0
})

function closeFlashAlert(){
  setTimeout(
    function(){
      $(".js-flash-alert").fadeTo(500, 0).slideUp(500, function(){
          $(this).remove();
      });
    },
  5000);
}

function onReady() {
  var inputRupiah = $('.js-rupiah');
  var realInputRupiah = $('.js-rupiah-real');
  inputRupiah.on('keyup', function(e){
    var value = e.target.value.replace(/\D/g,'')
    value = Number(value)
    inputRupiah.val(formatter.format(value));
    realInputRupiah.val(value);
  });
  inputRupiah.keyup();

  closeFlashAlert();
}

$(document).on('ready', onReady)
$(document).on('turbolinks:load', onReady)
