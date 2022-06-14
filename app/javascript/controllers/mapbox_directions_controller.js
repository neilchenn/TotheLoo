import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';




export default class extends Controller {
  static values = {
    apiKey: String,
    destination: Array,
    origin: Array,
    looName: String,
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue


    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      center: [144.9971274207717, -37.830719010],
      zoom: 12
    })

    this.map.on('load', this.onMapLoad.bind(this))
      if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(position => {
          const startingLocationInput = document.querySelector('#mapbox-directions-origin-input input')
          if (startingLocationInput) {
            this.originValue = [position.coords.longitude, position.coords.latitude]
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
          // inputs: true
        },
        placeholderOrigin: "Current Location",
        //steps: true,
        //banner_instructions: true,
      })


      this.map.addControl(
        this.directions,
        'top-left'
      );

      window.directions = this.directions

      this.map.on('load', () => {
        this.directions.setDestination(this.destinationValue)
        document.querySelector("#mapbox-directions-origin-input input").value = "Current location"
        document.querySelector("#mapbox-directions-destination-input input").value = this.looNameValue
      })
  }

  onMapLoad(e) {
    this.destinationInput = document.querySelector("#mapbox-directions-destination-input input")

    this.originInput = document.querySelector("#mapbox-directions-origin-input input")
    this.originInput.value = `${this.originValue[0]}, ${this.originValue[1]}`
    this.destinationInput.value = `${this.destinationValue[0]}, ${this.destinationValue[1]}`
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
