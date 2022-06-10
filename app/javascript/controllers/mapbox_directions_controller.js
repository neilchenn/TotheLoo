import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';




export default class extends Controller {
  static values = {
    apiKey: String,
    destination: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
    })

      // // Add geolocate control to the map.
      // this.map.addControl(
      //   new mapboxgl.GeolocateControl({
      //   positionOptions: {
      //     enableHighAccuracy: true
      //   },
      //   // When active the map will receive updates to the device's location as it changes.
      //   trackUserLocation: true,
      //   // Draw an arrow next to the location dot to indicate which direction the device is heading.
      //   showUserHeading: true,
      //   }),
      //   'bottom-right',
      // );

      if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(position => {
          const startingLocationInput = document.querySelector('#mapbox-directions-origin-input input')
          if (startingLocationInput) {
            const origin = [position.coords.longitude, position.coords.latitude]
           // const originInput = `${origin[0]}, ${origin[1]}`
            //startingLocationInput.value = origin
            this.directions.setOrigin(origin)
          }
        })
      }

      // this.map.Geolocation.getCurrentPosition();
      this.directions = new MapboxDirections({
        accessToken: mapboxgl.accessToken,
        unit: 'metric',
      })

      this.map.addControl(
        this.directions,
        'top-left'
      );

      this.map.on('load', () => {
        this.directions.setDestination(this.destinationValue)
      })
  }
}
