import JSConfetti from 'js-confetti'


const initConfetti = () => {
  if (!document.getElementById('confetti_button')) {
    return; // guard clause
  }

  const button = document.getElementById('confetti_button');
  const jsConfetti = new JSConfetti()

  button.addEventListener('click', () => {
    console.log("hello");
    jsConfetti.addConfetti( {
      emojis: ['๐งป', '๐ฉ', '๐ฝ', '๐'],
      emojiSize: 50,
    });
  })
}

export { initConfetti };
