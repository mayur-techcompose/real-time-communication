App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    element = '';
    imageUrl = '';
    console.log(parseInt($('#current-user').val()));
    if (data['message']['user_id'] == parseInt($('#current-user').val()) && parseInt($('#current-user').val()) == 1)
      imageUrl = "assets/techcompose.png"
    else
      imageUrl = "assets/dharinsir.jpeg"

    if (data['message']['user_id'] == parseInt($('#current-user').val()))
      element = '<div class="d-flex justify-content-end mb-4">'+
              '<div class="msg_cotainer_send">'+
                data['message']['content'] +
                '<span class="msg_time_send">Now</span>' +
            '</div>'+
            '<div class="img_cont_msg">'+
                '<img src='+
                 imageUrl +
            ' class="rounded-circle user_img">'+
            '</div>'+
        '</div>';
    else
      element = '<div class="d-flex justify-content-start mb-4">'+
            '<div class="img_cont_msg">'+
                '<img src='+
                 imageUrl +
            ' class="rounded-circle user_img">'+
            '</div>'+
            '<div class="msg_cotainer">'+
                data['message']['content']+
                '<span class="msg_time_send">Now</span>'+
            '</div>'+
        '</div>';
    $('.msg_card_body').append element
    $('.msg_card_body').animate({
        scrollTop: $(".msg_card_body").scrollTop() + 200
    }, 100);

  speak: (message, userId) ->
    messageData = {
      message: message,
      user_id: userId
    }
    @perform 'speak', data: messageData

  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 # return/enter = send
      App.room.speak(event.target.value, $('#current-user').val())
      event.target.value = ''
      event.preventDefault()
