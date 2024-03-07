float angleAdjust = 0.05;
float angleFactor = 1.25; // 225 degrees, range = 1.25 - 1.75 ()
float angl = (float) Math.PI * angleFactor; // 

class LaunchPad {
    boolean active = false;

    LaunchPad() {}

    void ignite() {
        active = true;

        particleList.add(new Fuse2(angl));

        angleFactor += angleAdjust;
        angl = (float) Math.PI * angleFactor;

        if (angleFactor > 1.70 || angleFactor < 1.30) angleAdjust *= -1;
    }
}
