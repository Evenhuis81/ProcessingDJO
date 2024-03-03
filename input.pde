void mousePressed() {
    if (startButton.inside()) startButton.press();
}

void mouseReleased() {
    if (startButton.pressed) {
        if (startButton.inside()) launchPad.start();

        startButton.release();
    }
}
