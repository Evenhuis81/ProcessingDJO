float angleAdjust = 0.05;
float angleFactor = 1.25; // 225°, range = 1.25 - 1.75 * PI (225 - 315°)
float angle = (float) Math.PI * angleFactor;
int size = 5;

class LaunchPad {
    LaunchPad() {}

    void ignite() {
        seq.start();
    }

    void igniteOne() {
        toAdd.add(new Fuse(width/2, height + size / 2, angle, size)); // x, y, angle, radius

        angleFactor += angleAdjust;
        angle = (float) Math.PI * angleFactor;

        if (angleFactor > 1.70 || angleFactor < 1.30) angleAdjust *= -1;
    }
}
