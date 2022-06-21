import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';
import { csrfToken } from "@rails/ujs";




export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array,
    coordinates: Object
  }


  connect() {
    const center = [144.9971274207717, -37.830719010]
    // this.coordinatesValue.lat ? this.coordinatesValue : [144.9971274207717, -37.830719010]
    mapboxgl.accessToken = this.apiKeyValue
    console.log(this.coordinatesValue)
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
      center: center,
      zoom: 14
    })


      // Add geolocate control to the map.
      this.map.addControl(
        new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        // When active the map will receive updates to the device's location as it changes.
        trackUserLocation: true,
        // Draw an arrow next to the location dot to indicate which direction the device is heading.
        showUserHeading: true,
        }),
        "bottom-right"
      );

      // To get the current position
      if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(position => {
          console.log(position)
          this.#patchUserLocation(position)
          const startingLocationInput = document.querySelector('#mapbox-directions-origin-input input')
          if (startingLocationInput) {

            startingLocationInput.value = `${position.coords.latitude}, ${position.coords.longitude}`
          }
        })
      }

      // this.map.Geolocation.getCurrentPosition();

    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)

      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundColor = `pink`
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"
      customMarker.style.borderRadius = '25px'
      customMarker.style.border = '2px solid white'
      customMarker.style.backgroundSize = '75% 75%';
      customMarker.style.backgroundPosition = 'center center';
      customMarker.style.backgroundRepeat = 'no-repeat';

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    });
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: {top: 10, bottom:25, left: 15, right: 5}
      , maxZoom: 15, duration: 0 })
  }

  #patchUserLocation(position) {
    fetch(`/user/location?latitude=${position.coords.latitude}&longitude=${position.coords.longitude}`, {
      method: 'PATCH',
      headers: { "Accept": "application/json", "X-CSRF-Token": csrfToken() }
    })
  }


}
