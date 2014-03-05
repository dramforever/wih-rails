# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready= ->
  $(".fancy").fancybox()
  
  $("#btn1").on 'click', ->
    $("#selected").val(1)
  
  $("#btn2").on 'click', ->
    $("#selected").val(2)

  $("form.edit_image").ajaxForm {
    dataType: "json"
    success: (o) ->
      $("#btn1").attr class: "btn btn-success offset1"
      $("#btn1").html percentage o.image1

      $("#btn2").attr class: "btn btn-success offset2"
      $("#btn2").html percentage o.image2

      $("#selected").val(0)

      $("#btn1").on 'click', ->
        alert "请不要重复点击，谢谢"
      $("#btn2").on 'click', ->
        alert "请不要重复点击，谢谢"

      $("form.edit_image").attr action: '#'
  }

  $("#refresh").on 'click', ->
    location.reload()

  percentage= (num) ->
    a = parseInt(num*100)
    a += '%'
    return a
$(document).ready(ready)
$(document).on('page:load', ready)
