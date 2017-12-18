int rMin = 2, rMax = 100, countMax = 36;
color bg = color(150), maskC = color(255);
PImage graphic;

void setup() {
  size(600, 600);
  background(bg);
}

void draw() {
  if (mousePressed) {
    stroke(maskC);
    strokeWeight(100);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

void mousePressed() {
  if (graphic != null) image(graphic, 0, 0);
}
void mouseReleased() {
  graphic = this.getGraphics();
  loadPixels();
  println("save");
}

void keyPressed() {
  image(graphic, 0, 0);
  for (int i = 0; i < 1000; i++) drawCircle();
}

void drawCircle() {
  int r = (int)random(rMin, rMax), x = (int)random(width), y = (int)random(height);

  while (get(x, y) != maskC) {  // center color == mask color (=not painted)
    r = (int)random(rMin, rMax);
    x = (int)random(width);
    y = (int)random(height);
  }

  color paintC = color((int)random(120, 255), (int)random(120, 255), (int)random(120, 255));

  while (paintC == maskC) {  // paint color != mask color
    paintC = color((int)random(120, 255), (int)random(120, 255), (int)random(120, 255));
  }
  noStroke();
  fill(paintC);

  while (r > 0) {
    int count = 0;

    for (int i = 0; i < countMax; i++) {  // edge color == mask color (=not painted)
      int gx = x + (int)( r * cos(radians(i * 360/countMax)) );
      int gy = y + (int)( r * sin(radians(i * 360/countMax)) );
      if (get(gx, gy) == maskC) count++;
    }
    if (count != countMax) r--;

    if (count == countMax) {
      ellipse(x, y, 2 * r, 2 * r);
      break;
    }
  }
}