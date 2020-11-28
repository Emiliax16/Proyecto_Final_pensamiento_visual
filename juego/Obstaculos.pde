class Obstaculos {
  float size, x, y;

  int vy = 5; //speed of asteroid

  Obstaculos(float size) {
    this.size = size;
    this.x = random(width);
    this.y = -size;
  }
  //equis de

  void drawObstaculos() {
    fill(150);
    stroke(15);
    image(p, x, y, size, size);
    y+=vy;
  }

  boolean checkCollision(Object other) {
    if (other instanceof Ship) {
      Ship playerShip = (Ship) other;
      float apothem = 10 * tan(60);
      float distance = dist(x, y, playerShip.x, playerShip.y-apothem);
      if (distance < size/2 + apothem + 5) {
        //background(255, 0, 0);
        //fill(255, 0, 0, 100);
        //rect(0, 0, width, height);
        //fill(255);
        
        return true;
      }
    }
    return false;
    
  }
}
