import consumer from "./consumer"


document.addEventListener('turbolinks:load',() => {

  window.messageContainer = document.getElementById("chat-messages");
  
  if(messageContainer === null){
    return
  }


  const appChatRoom = consumer.subscriptions.create("ChatRoomChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      const chatMessages = document.getElementById("chat-messages");
      chatMessages.insertAdjacentHTML("beforeend", data["chat_message"])
      scrollToBottom();
      // Called when there's incoming data on the websocket for this channel
    },
  
    speak: function(chat_message,chat_room_id) {
      return this.perform('speak',{ chat_message: chat_message, chat_room_id: chat_room_id});
    }
  });


  let scrollHeight = document.getElementById("chat-messages").scrollHeight;
  let scrollToBottom = () => {
    document.getElementById("chat-messages").scrollTop = scrollHeight;
  }
  scrollToBottom();



  if(/chat_rooms/.test(location.pathname)){
    $(document).on("keydown", ".chat-room__message-form_textarea", function(e){
      if (e.key === "Enter"){

        if(!e.target.value.trim()){
          return
        }
  
        const chat_room_id =$("textarea").data("chat_room_id");
        appChatRoom.speak(e.target.value, chat_room_id);
        e.target.value = '';
        e.preventDefault();
      }
    })
  }



})




