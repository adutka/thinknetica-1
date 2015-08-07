# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-' + answer_id).show();
  console.log 'qqq'



  $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    # console.log "hello from coffe script"
    # console.log e
    # console.log data
    # console.log status
    # console.log xhr
    answer = $.parseJSON(xhr.responseText)
    #$('.answers').append('<p>' + answer.body + '</p>')
    #$('.answers').load("views/answers/_answer.html");
    console.log(answer)
    #$('.answers').append '<a data-remote="true" data-method="post" data-params="param1=Hello+server" href="/test">AJAX action with POST request</a>'
    html = HandlebarsTemplates['answers/new'](answer);
    #html = new EJS({url: '/assets/templates/answer.ejs'}).render(answer)
    console.log(html)
    if answer.id
      $('.notice').html 'Your answer successfully created.'
    else
      $('.notice').html 'Answer body can\'t be blank.'
    $('.answers').append(html)
    #$('.answers').append(JST['assets/templates/answer'](answer))
    # $('.answers').append '<div>' + '<p>' + answer.body + '</p>' + '<a href="/questions/' + answer.question_id + '/answers/' + answer.id + '/edit">Edit answer</a>' + '<br>' + '<a data-remote="true" rel="nofollow" data-method="delete" href="/answers/' + answer.id + '">' + 'Delete answer</a>' + '<br>' + '<a data-remote="true" rel="nofollow" data-method="post" href="/questions/' + answer.question_id + '/answers/' + answer.id + '/best">' + 'Best answer' + '</a>' + '</div>'
    # $('form.new_answer').find('input:text,textarea').val('')
    # $('.answers').load("answers/views/_answer.html.slim");
  .bind 'ajax:error', (e, xhr, status, error) ->
    $('.notice').html("Answer body can't be blank.");

    #$('.answers').html(answer$.parseJSON(xhr.responseText))
    # xhr.responseText - body of answer

    #$('.answers').append('<p>' + answer.body + '</p>')
    # append - Insert content, specified by the parameter, to the end of each element in the set of matched elements.

  # .bind 'ajax:error', (e, xhr, status, error) ->
  #   # e-event, xhr - our answer, status - code of error, error - text of error
  #   $('.answer-errors').html(xhr.responseText)

    # $('.answers-errors').respondjs(xhr.responseText)

  #.bind 'ajax:error', (e, xhr, status, error) ->


  #  $('.answers').append(
  #  '<div>'+
  #   '<p>'+
  #     answer.body +
  #   '</p>'+
  #   '<a href="/questions/' + answer.question_id + '/answers/' + answer.id + '/edit">Edit answer</a>'+
  #   '<br>'+
  #   '<a data-remote="true" rel="nofollow" data-method="delete" href="/answers/' + answer.id + '">'+
  #   'Delete answer</a>'+
  #   '<br>'+
  #   '<a data-remote="true" rel="nofollow" data-method="post" href="/questions/' + answer.question_id + '/answers/' + answer.id + '/best">' + 'Best answer'+
  #   '</a>' +
  # '</div>');

    #.bind 'ajax:error', (e, xhr, status, error) ->

   # errors = $.parseJSON(xhr.responseText)

   # $.each errors, (index, value) ->

     # $('.answer-errors').append(value)









    # answer = $.parseJSON(xhr.responseText)
    # console.log $('.answers')
    #$('.answers').append('<p>' + answer.body + '</p>')
    # console log "append"
    # $('form.new_answer').find('input:text,textarea').val('')
    # $('form.new_answer').find('.container.answer_errors').empty()
    # .bind 'ajax:error', (e, xhr, status, error) ->
    # errors = $.parseJSON(xhr.responseText)
    # $.each errors, (index, value) ->
      # $('.container.answer_errors').append(value)
