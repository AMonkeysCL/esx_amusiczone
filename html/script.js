let isPlaying = false;
let audio = new Audio();

window.addEventListener('message', function(event) {
    let data = event.data;

    if (data.type === 'playMusic') {
        if (!isPlaying) {
            isPlaying = true;
            audio.src = data.link;
            audio.volume = data.volume;
            audio.play();
        }
    } else if (data.type === 'stopMusic') {
        if (isPlaying) {
            isPlaying = false;
            audio.pause();
            audio.currentTime = 0;
        }
    }
});

function setVolume() {
    let volume = document.getElementById('volume').value;
    volume = parseFloat(volume);
    audio.volume = volume;
    $.post('http://esx_amusiczone/updateVolume', JSON.stringify({ volume: volume }));
}

function playMusic() {
    let link = document.getElementById('link').value;
    $.post('http://esx_amusiczone/playMusic', JSON.stringify({ link: link }));
}

function stopMusic() {
    $.post('http://esx_amusiczone/stopMusic', JSON.stringify({}));
}
