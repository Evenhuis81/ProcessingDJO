class Statistics {
    ArrayList<String> stats = new ArrayList<String>();

    Statistics() {
        println("Statistics created");
    }

    void addText(int i, String txt) {
        stats.add(i, txt);
    }

    void setText(int i, String txt) {
        stats.set(i, txt);
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
