
PShape s;
void setup() {
  size(800, 800);
  s = loadShape("data/calle.svg");
}

void draw() {
  shape(s, 0, 0, 800, 800);
}
