Ship playerShip;

ArrayList<Obstaculos> obstaculos = new ArrayList<Obstaculos>();
int obstaculosFrequency = 10; // LOWER == MORE OBSTACULOS
int segundos = 0;
//OPTION ONE -- A single bullet at a time
//Bullet bullets;

//OPTION TWO -- Multiple bullets at a time
//ArrayList<Bullet> bullets = new ArrayList<Bullet>();

//int points;

EndScene end;
PShape s;
//equis de
void setup() {
  // fullScreen(P2D);
  size(800, 800);
  playerShip = new Ship();
  //frameRate(100);
  //points = 0;
  s = loadShape("data/calle.svg");
  //noStroke();
}

void draw() {
  //delay(1000);
  if (end != null) {
    end.drawEndScene();
  } else if (10 > segundos) { 
    shape(s, 0, 0, 800, 800);
    drawObstaculos();
    fill(255, 0, 0);
    stroke(255);
    playerShip.drawShip();
    checkCollision();
  }
}


void checkCollision() {
  for (int i = 0; i < obstaculos.size(); i++) {
    Obstaculos a = obstaculos.get(i);
    if (a.checkCollision(playerShip) == true) {
      end = new EndScene();
    }
  }
}


void drawObstaculos() {
  if (frameCount % obstaculosFrequency == 0) {
    obstaculos.add(new Obstaculos(random(40, 100)));
  }
  for (int i = 0; i<obstaculos.size(); i++) {
    Obstaculos currentObstaculos = obstaculos.get(i);
    currentObstaculos.drawObstaculos();
    if (currentObstaculos.y > height + currentObstaculos.size) {
      obstaculos.remove(currentObstaculos);
      i--;
    }
  }
}



void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      playerShip.upPressed = true;
    } else if (keyCode == DOWN) {
      playerShip.downPressed = true;
    } else if (keyCode == LEFT) {
      playerShip.leftPressed = true;
    } else if (keyCode == RIGHT) {
      playerShip.rightPressed = true;
    }
  } 
}

void keyReleased() {
  if (keyCode == UP) {
    playerShip.upPressed = false;
  } else if (keyCode == DOWN) {
    playerShip.downPressed = false;
  } else if (keyCode == LEFT) {
    playerShip.leftPressed = false;
  } else if (keyCode == RIGHT) {
    playerShip.rightPressed = false;
  }
}

void mousePressed() {
  if (end != null && end.mouseOverButton() == true) {
    resetGame();
  }
}

void resetGame() {
  obstaculos.clear();
  playerShip = new Ship();
  end = null;
}
