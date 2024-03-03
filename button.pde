class Button {
    int x, y, w, h, r, s, fillC, strokeC; // r: rounded corner, s: textSize
    float textDesc; // correction for vertical alignment
    String txt;
    boolean pressed;

    Button() { // default constructor
        txt = "Button";
        x = 0;
        y = 0;
        w = 100;
        h = 40;
        r = 5;
        s = 30;
        fillC = 0;
        strokeC = 255;
        textSize(s);
        textDesc = 0.6 * textDescent();
        pressed = false;
    }

    Button(String buttonText, int x, int y) {
        this();
        txt = buttonText;
        this.x = x;
        this.y = y;
    }

    boolean inside() {
        return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
    }

    void press() {
        pressed = true;
        fillC = 100;
    }

    void release() {
        fillC = 0;
        pressed = false;
    }

    void show() {
        stroke(strokeC);
        strokeWeight(2);
        fill(fillC);
        rect(x, y, w, h, r);

        textAlign(CENTER, CENTER);
        textSize(s);
        fill(255);
        text(txt, x + w/2, y + h/2 - textDesc);

        // line to check middle of text for vertical alignment
        // strokeWeight(1);
        // line(x, y + h/2, x + w, y + h/2);
    }
}
