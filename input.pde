void mousePressed() {
    if (button.inside()) button.press();
}

void mouseReleased() {
    if (button.pressed) {
        button.release();
        
        if (button.inside()) {
            // clicked button: action here
            println("click");
        }
    }
}
