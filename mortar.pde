float angleAdjust = 0.05;
float angleFactor = 1.25; // 225°, range = 1.25 - 1.75 * PI (225 - 315°)
float angle = (float) Math.PI * angleFactor;
int size = 5;

interface SequenceMethod {
    void method();
}

class Sequence {
    // int[] thresholds = { 1000, 200, 200, 200 };
    int[] thresholds = { 1500 };
    SequenceMethod[] methods = new SequenceMethod[] {
        new SequenceMethod() { void method() { mortar.sequenceOne(); } },
        // new SequenceMethod() { void method() { mortar.sequenceOne(); } },
        // new SequenceMethod() { void method() { mortar.sequenceOne(); } },
        // new SequenceMethod() { void method() { mortar.sequenceOne(); } },
    };

    Sequence() {
        // println(thresholds[0]);
    }

    // public void goNorth() { ... }
    // public void goSouth() { ... }
    // public void goEast() { ... }
    // public void goWest() { ... }

    // interface MoveAction {
    //     void move();
    // }

    // private MoveAction[] moveActions = new MoveAction[] {
    //     new MoveAction() { public void move() { goNorth(); } },
    //     new MoveAction() { public void move() { goSouth(); } },
    //     new MoveAction() { public void move() { goEast(); } },
    //     new MoveAction() { public void move() { goWest(); } },
    // };

    // public void move(int index) {
    //     moveActions[index].move();
    // }
}

// Sequence sequence = new Sequence();

class Mortar {
    // int[] thresholds = { 1000, 2000, 3000, 4000, 4100, 4200, 4300, 4400, 4500, 4600, 4700, 4800 };\
    int[] thresholds = { 1500 };
    SequenceMethod[] methods = new SequenceMethod[] {
        new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
        // new SequenceMethod() { void method() { sequenceOne(); } },
    };

    Mortar() {}

    void sequenceOne() {
        toAdd.add(new MortarShell(width/2, color(255, 0, 0))); // x, color
    }

    // void sequenceTwo() {
    //     toAdd.add(new MortarShell(new PVector(width/2, height + size / 2), angle, size)); // x, y, angle, radius

    //     angleFactor += angleAdjust;
    //     angle = (float) Math.PI * angleFactor;

    //     if (angleFactor > 1.70 || angleFactor < 1.30) angleAdjust *= -1;
    // }

    void ignite() {
        seq.setSequence(thresholds, methods);

        seq.start();
    }
}
