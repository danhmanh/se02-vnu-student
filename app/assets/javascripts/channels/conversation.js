App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function() {},

  disconnected: function() {},

  received: function(data) {
    let conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");

    if (data['window'] !== undefined) {
      let conversation_visible = conversation.is(':visible');

      if (conversation_visible) {
        let messages_visible = (conversation).find('.panel-body').is(':visible');

        if (!messages_visible) {
          conversation.removeClass('panel-default').addClass('panel-success');
        }
        conversation.find('.messages-list').find('ul').append(data['message']);
      }
      else {
        $('#conversations-list').append(data['window']);
        conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
        conversation.find('.panel-body').toggle();
      }
    }
    else {
      conversation.find('ul').append(data['message']);
    }

    let messages_list = conversation.find('.messages-list');
    let height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },

  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});

$(document).on('keypress', '.new_message', function(e) {
  if(e.keyCode == 13){
    e.preventDefault();
    let values = $(this).serializeArray();
    App.conversation.speak(values);
    $(this).trigger('reset');
  }
});
