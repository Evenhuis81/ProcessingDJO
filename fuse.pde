class Fuse {
    int count = 0;
    boolean exploded = false;

    Fuse(float x, float y, float angle, int radius) {
        ParticleWithTrail fuse = new ParticleWithTrail(random(15, 30));
        fuse.pos.set(x, y);
        fuse.applyForce(new PVector(0, 0.022)); // gravity
        fuse.vel = PVector.fromAngle(angle).mult(5); // launch direction + speed
        particleList.add(fuse);
    }

    void update() {
        super.update();

        if (count > 90 && !exploded) explode(30);

        count++;
    }

    // void show() {
    //     if (!exploded) super.show();
    // }

    void explode(int amount) {
        Particle[] particles = new Particle[amount];

        for (int i = 0; i < particles.length; i++) {
            particles[i] = new Particle(pos, PVector.random2D());
        }
        
        toAdd.addAll(Arrays.asList(particles));
        toRemove.add(this);
    }
}

//   Spark(PVector pos) {
//         size = 5;
//         opacity = 257;
//         red = (int) random(256);
//         green = (int) random(256);
//         blue = (int) random(256);
//         applyForce(new PVector(0.01, 0.05));
//         vel.y -= 1;
//         strokeC = color(red, green , blue, opacity);
//     }

//     void update() {
//         super.update();

//         strokeC = color(red, green , blue, opacity);

//         opacity -= 2;
//         if (opacity <= 0) toRemove.add(this);
//     }

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
