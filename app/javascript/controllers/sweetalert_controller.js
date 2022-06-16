import swal from 'sweetalert';
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "link" ]

  popup() {
    const options = {
      title: "Are you sure?",
      text: "This loo will be permanently deleted from your favourites",
      icon: "warning"
    }

    swal(options).then((value) => {
      if (value) {
        this.linkTarget.click();
      }
    })
  }
}



// const initSweetalert = (selector, options = {}, callback = () => {}) => {
//   console.log("hi");
//   const swalButton = document.querySelector(selector);
//   if (swalButton) { // protect other pages
//     swalButton.addEventListener('click', () => {
//       swal(options).then(callback); // <-- add the `.then(callback)`
//     });
//   }
// };
