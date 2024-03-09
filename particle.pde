class Particle {
    PVector pos = new PVector(); // no params = { x: 0, y: 0 }
    PVector vel = new PVector();
    PVector acc = new PVector();
    int red = (int) random(256);
    int green = (int) random(256);
    int blue = (int) random(256);
    int alpha = 255;
    int strokeColor = color(red, green, blue, alpha);
    int radius = 4;

    Particle() {} // default constructor

    void applyForce(PVector force) {
        // F = M * A (force = mass * acceleration), mass ommited
        acc.add(force);
    }

    void removeForce(PVector force) {
        acc.sub(force);
    }

    void update() {
        vel.add(acc);
        pos.add(vel);
    }

    void show() {
        stroke(strokeColor);
        strokeWeight(radius * 2);
        point(pos.x, pos.y);
    }
}

class Tail extends Particle {
    ArrayList<PVector> tail = new ArrayList<PVector>();
    float tailAlpha, step;
    int length;

    Tail() {}

    void stop() {
        step = 1 / tail.size() + 1
    }

    void update() {
        tail.add(pos.copy());

        super.update();

        if (tail.size() > length) tail.remove(0);
    }

    void show() { 
        super.show();

        for (int i = tail.size(); i > 0; i--) {
            PVector hPos = tail.get(i-1);
            
            tailAlpha = (float) i / (tail.size() + 1) * 255; // + 1 = include particle

            println(tailAlpha);

            stroke(red, green, blue, tailAlpha);
            point(hPos.x, hPos.y);
        }
    }
}
