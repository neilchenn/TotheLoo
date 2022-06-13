import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("nearest loo connected")
    this.getLocation()
      // To get the current position
      // if ("geolocation" in navigator) {
      //   navigator.geolocation.getCurrentPosition(position => {
      //     console.log(position)
      //     debugger
      //     startingLocationInput.value = `${position.coords.latitude}, ${position.coords.longitude}`
      //   })
      // }
  }

  getLocation() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.addPositionToLink.bind(this), this.handleError);
    } else {
      console.error("Geolocation is not supported by this browser.");
    }
  }

  handleError(error) {
    let errorStr;
    switch (error.code) {
      case error.PERMISSION_DENIED:
        errorStr = 'User denied the request for Geolocation.';
        break;
      case error.POSITION_UNAVAILABLE:
        errorStr = 'Location information is unavailable.';
        break;
      case error.TIMEOUT:
        errorStr = 'The request to get user location timed out.';
        break;
      case error.UNKNOWN_ERROR:
        errorStr = 'An unknown error occurred.';
        break;
      default:
        errorStr = 'An unknown error occurred.';
    }
    console.error('Error occurred: ' + errorStr);
  }

  addPositionToLink(position) {
    this.element.href += `?latitude=${position.coords.latitude}&longitude=${position.coords.longitude}`
    //console.log(`Latitude: ${position.coords.latitude}, longitude: ${position.coords.longitude}`);
  }
}
