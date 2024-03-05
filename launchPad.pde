class LaunchPad {
    boolean active = false;

    LaunchPad() {}

    void ignite() {
        active = true;

        particleList.add(new Fuse(mouseX));
    }
}
