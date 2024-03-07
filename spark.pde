class Spark extends Particle {
    int red, green, blue, opacity;

    Spark(PVector pos) {
        this.pos.set(pos.x, pos.y);
        vel.set(PVector.random2D());
        size = 5;
        opacity = 257;
        red = (int) random(256);
        green = (int) random(256);
        blue = (int) random(256);
        applyForce(new PVector(0.01, 0.05));
        vel.y -= 1;
        strokeC = color(red, green , blue, opacity);
    }

    void update() {
        super.update();

        strokeC = color(red, green , blue, opacity);

        opacity -= 2;
        if (opacity <= 0) toRemove.add(this);
    }
}
