// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// Stimulus controller imports
import "controllers"

// external imports
import "bootstrap"
import { hide } from "@popperjs/core"


// local imports


import { initHideLoadingScreen } from "../components/init_hide_loading_screen"
import { initConfetti } from "../components/init_confetti"

document.addEventListener('turbolinks:load', (event) => {
  initHideLoadingScreen(event);
  initConfetti();
});

import { initSweetalert } from '../components/init_sweetalert';

initSweetalert('#sweet-alert-demo', {
  title: "Are you sure?",
  text: "This loo will be permanently deleted from your favorites",
  icon: "warning"
}, (value) => {
  if (value) {
    const link = document.querySelector('#delete-link');
    link.click();
  }
});
