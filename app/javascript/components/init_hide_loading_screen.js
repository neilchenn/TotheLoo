const hideLoadingScreen = () => {
  const loadingScreen = document.getElementById('loading-screen')
  loadingScreen.classList.remove('active')
}

const initHideLoadingScreen = (event) => {
  const isRootPath = window.location.pathname === '/'
  if (isRootPath) {
    // initial page load
    setTimeout(hideLoadingScreen, 2000)
  } else {
    hideLoadingScreen()
  }
}

export { initHideLoadingScreen }
