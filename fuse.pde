class Fuse2 extends Particle {
    ArrayList<PVector> history = new ArrayList<PVector>();
    int historyLength, red, green, blue, alpha, count;
    color fuseStrokeC;
    float angle;

    Fuse2(float angle) {
        count = 0;
        pos.set(width/2, height + size / 2);
        applyForce(new PVector(0, 0.022)); // gravity
        // vel.y = random(-4, -3); // launch speed
        this.angle = angle;
        vel = PVector.fromAngle(angle).mult(5);
        historyLength = (int) random(15, 30);
        red = (int) random(256);
        green = (int) random(256);
        blue = (int) random(256);
        strokeC = color(red, green, blue);
    }

    void update() {
        history.add(pos.copy());

        if (history.size() > historyLength) history.remove(0);

        super.update();

        // if (vel.y > 0) {
            if (count > 90) {
            toRemove.add(this);
            explode(60);
        }

        count++;
    }

    void show() {
        super.show();

        for (int i = history.size(); i > 0; i--) {
            PVector hPos = history.get(i-1);
            
            float alpha = (float) i / history.size() * 255;

            fuseStrokeC = color(red, green, blue, alpha);

            stroke(fuseStrokeC);
            point(hPos.x, hPos.y);
        }
    }

    void explode(int amount) {
        Particle[] sparks = new Particle[amount];

        for (int i = 0; i < sparks.length; i++) {
            sparks[i] = new Spark(pos);
        }
        
        toAdd.addAll(Arrays.asList(sparks));
    }
}

class Fuse extends Particle {
    ArrayList<PVector> history = new ArrayList<PVector>();
    int historyLength, red, green, blue, alpha;
    color fuseStrokeC;

    Fuse(float x) {
        pos.set(x, height + size / 2);
        applyForce(new PVector(0, 0.015)); // gravity
        vel.y = random(-4, -3); // launch speed
        historyLength = (int) random(15, 30);
        red = (int) random(256);
        green = (int) random(256);
        blue = (int) random(256);
        strokeC = color(red, green, blue);
    }

    void update() {
        history.add(pos.copy());

        if (history.size() > historyLength) history.remove(0);

        super.update();

        if (vel.y > 0) {
            toRemove.add(this);
            explode(30);
        }
    }

    void show() {
        super.show();

        for (int i = history.size(); i > 0; i--) {
            PVector hPos = history.get(i-1);
            
            float alpha = (float) i / history.size() * 255;

            fuseStrokeC = color(red, green, blue, alpha);

            stroke(fuseStrokeC);
            point(hPos.x, hPos.y);
        }
    }

    void explode(int amount) {
        Particle[] sparks = new Particle[amount];

        for (int i = 0; i < sparks.length; i++) {
            sparks[i] = new Spark(pos);
        }
        
        toAdd.addAll(Arrays.asList(sparks));
    }
}

// class Fuse2 extends Particle {
//     float startX, speed, minX, maxX, xCorrection; // xCorrection = amount of repositioning on x-axis for new launch
//     // boolean added = false;

//     Fuse1(float x, float y, float minX, float maxX, float xCor) {
//         pos.set(x, y);
//         this.minX = minX;
//         this.maxX = maxX;
//         startX = x;
//         xCorrection = xCor;

//         // reposition when out of range and reverse xCorrection
//         if (startX < minX || startX > maxX ) {
//             xCorrection *= -1;
//             startX += xCorrection * 2;
//             pos.x = startX;
//         }

//         applyForce(new PVector(0, 0.3));
//         vel.y = random(-20, -16);
//     }

//     void update() {
//         super.update();

//         if (vel.y > 0) {
//             toRemove.add(this);
//             toAdd.add(new Fuse1(startX + xCorrection, height + 5, minX, maxX, xCorrection));
//             explode();
//         }
//     }

//     void explode() {
//         Particle[] sparks = new Particle[50];

//         for (int i = 0; i < sparks.length; i++) {
//             sparks[i] = new Spark(pos);
//         }
        
//         toAdd.addAll(Arrays.asList(sparks));
//     }
// }
