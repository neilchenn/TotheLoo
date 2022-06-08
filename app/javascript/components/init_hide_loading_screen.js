const hideLoadingScreen = () => {
  const loadingScreen = document.getElementById('loading-screen')
  loadingScreen.classList.remove('active')
}

const initHideLoadingScreen = (event) => {
  if (!event.data.timing.visitStart) {
    // initial page load
    setTimeout(hideLoadingScreen, 2000)
  } else {
    hideLoadingScreen()
  }
}

export { initHideLoadingScreen }
