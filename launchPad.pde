class LaunchPad {
    boolean active = false;

    LaunchPad() {}

    void ignite() {
        if (active) return;

        active = true;

        float xCor = -((width - width * 0.1 * 2) / 10);

        particleList.add(new Fuse1(width * 0.9, height + 5, width * 0.1, width * 0.9, xCor));
    }
}
