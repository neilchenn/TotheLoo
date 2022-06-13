import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';




export default class extends Controller {
  static values = {
    apiKey: String,
    destination: Array,
    origin: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue


    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      zoom: 12
    })

    this.map.on('load', this.onMapLoad.bind(this))
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
            this.originValue = [position.coords.longitude, position.coords.latitude]
           // const originInput = `${origin[0]}, ${origin[1]}`
            //startingLocationInput.value = origin
            this.directions.setOrigin(this.originValue)
          }
        })
      }

      // this.map.Geolocation.getCurrentPosition();
      this.directions = new MapboxDirections({
        accessToken: mapboxgl.accessToken,
        unit: 'metric',
        controls: {
          // instructions: false
        },
        //steps: true,
        //banner_instructions: true,
      })

      this.map.addControl(
        this.directions,
        'top-left'
      );

      this.map.on('load', () => {
        this.directions.setDestination(this.destinationValue)
      })
  }

  onMapLoad(e) {
    this.destinationInput = document.querySelector("#mapbox-directions-destination-input input")
    this.destinationInput.value = `${this.destinationValue[0]}, ${this.destinationValue[1]}`

    this.originInput = document.querySelector("#mapbox-directions-origin-input input")
    this.originInput.value = `${this.originValue[0]}, ${this.originValue[1]}`
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    if (this.hasOriginValue) {
      bounds.extend(this.originValue)
    }
    bounds.extend(this.destinationValue)

    if (this.map) {
      this.map.fitBounds(bounds,
                        { padding: {
                            top: 10,
                            bottom:25,
                            left: 15,
                            right: 5
                          },
                          maxZoom: 15,
                          duration: 300
                        })
    }
  }

  destinationValueChanged(value, previousValue) {
    this.#fitMapToMarkers()
  }

  originValueChanged(value, previousValue) {
    this.#fitMapToMarkers()
  }
}
