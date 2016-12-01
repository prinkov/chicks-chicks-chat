var standartWidth = 360
var standartHeight = 640
var screenWidth = standartWidth
var screenHeight = standartHeight

function getWidth(width) {
    return width * screenWidth / standartWidth ;
}

function getHeight(height) {
    return height * screenHeight / standartHeight;
}

function getPointSize (size) {
    return size * screenHeight / standartHeight;
}
