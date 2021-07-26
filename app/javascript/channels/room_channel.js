import consumer from "./consumer"

document.addEventListener("turbolinks:load", () => {
  var element = document.getElementById('room-id')
  if (element) {
    const room_id = element.getAttribute('data-room-id')

    consumer.subscriptions.create({channel: "RoomChannel", room_id: room_id}, {
      connected() {
        element.innerHTML += '<p>connected to room channel: ' + room_id + '</p>'
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log(data);
        element.innerHTML += '<p>message: ' + data.message + '</p>'
      }
    })  
  }
})
