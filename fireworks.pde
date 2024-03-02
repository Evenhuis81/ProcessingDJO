int backgroundColor = 0;
Button button;

void setup() {
    size(800, 600);
    button = new Button("start", width-120, 20);
}

void draw() {
    background(backgroundColor);

    // particle.update();
    // particle.show();
    button.show();
}
