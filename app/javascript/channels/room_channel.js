import consumer from "./consumer"

const d = document;

const hours = time => Math.floor(time / 3600)
const minutes = time => Math.floor(time % 3600 / 60)
const seconds = time => Math.floor( time % 60)
const getTime = time => `${hours(time)}:${minutes(time)}:${seconds(time)}`

const createTimer = time => {
  console.log(time)
  const timerView = d.getElementById("timer")
  let timerval = parseFloat(time)
  setInterval(() => {
    timerView.innerHTML = getTime(timerval)
    timerval += 1
  }, 1000);
}

d.addEventListener("turbolinks:load", () => {
  let timerval = d.getElementById('timer');
  if (timerval) createTimer(timerval.getAttribute("timervalue"))

  var element = d.getElementById('room-id')
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
