import { Controller } from "@hotwired/stimulus";
import mapboxgl from "mapbox-gl";
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder";
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';




export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v11",
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
        'bottom-right',
      );

      // To get the current position
      if ("geolocation" in navigator) {
        navigator.geolocation.getCurrentPosition(position => {
          console.log(position)
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
      customMarker.style.border = '1px solid pink'
      customMarker.style.backgroundSize = '75% 75%';
      customMarker.style.backgroundPosition = 'center center';
      customMarker.style.backgroundRepeat = ' no-repeat';

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


}
