class Spark extends Particle {
    int red, green, blue, opacity;

    Spark(PVector pos) {
        this.pos.set(pos.x, pos.y);
        vel.set(PVector.random2D());
        size = 5;
        opacity = 255;
        red = (int) random(256);
        green = (int) random(256);
        blue = (int) random(256);
        applyForce(new PVector(0.01, 0.05));
        // vel.y += -2;
        strokeC = color(red, green , blue, opacity);
    }

    void update() {
        super.update();

        opacity -= 2;;
        strokeC = color(red, green , blue, opacity);

        if (opacity <= 0) {
            toRemove.add(this);
        }
    }
}
