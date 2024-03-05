class Statistics {
    ArrayList<String> stats = new ArrayList<String>();

    Statistics() {
        addText(0, "Particles length: ");
        // addText(1, "xCor: ");
        // addText(2, "startX: ");
        // addText(3, "minX: ");
        // addText(4, "maxX: ");
    }

    void addText(int i, String txt) {
        stats.add(i, txt);
    }

    void setText(int i, String txt) {
        stats.set(i, txt);
    }

    void update() {
        setText(0, "Particles length: " + particleList.size());
        // setText(1, "xCor: " + xCorrection);
        // setText(2, "startX: " + startX);
        // setText(3, "minX: " + minX);
        // setText(4, "maxX: " + maxX);
    }

    void show() {
        for (int i = 0; i < stats.size(); i++) {
            textAlign(LEFT, TOP);
            textSize(26);
            fill(255);
            text(stats.get(i), 0, i * 30);
        }
    }
}
