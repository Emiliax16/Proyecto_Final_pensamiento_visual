import processing.sound.*;
SoundFile mp31, mp32;

Ship playerShip;

ArrayList<Obstaculos> obstaculos = new ArrayList<Obstaculos>();
int obstaculosFrequency = 120; // LOWER == MORE OBSTACULOS
int segundos = 0;
int ran1, ran2;

StartScene start;
EndScene end;
PShape s;

PImage b;


void setup() {
  // fullScreen(P2D);
  size(800, 800);
  playerShip = new Ship();
  //frameRate(100);
  //points = 0;
  s = loadShape("data/calle.svg");
  b = loadImage("data/bicicleta.png");
  //noStroke();
  start = new StartScene();
  
  mp31 = new SoundFile(this, "relato_sofia.mp3");
  mp32 = new SoundFile(this, "professional.mp3");
}

void draw() {
  if (start != null) {
    start.drawStartScene();
  } else if (end != null) {
    end.drawEndScene();
    mp31.stop();
  } else if (10 > segundos) { 
    shape(s, 0, 0, 800, 800);
    drawObstaculos();
    //fill(255, 0, 0);
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
    obstaculos.add(new Obstaculos(random(ran1, ran2)));
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
      //playerShip.upPressed = true;
    } else if (keyCode == DOWN) {
      //playerShip.downPressed = true;
    } else if (keyCode == LEFT) {
      playerShip.leftPressed = true;
    } else if (keyCode == RIGHT) {
      playerShip.rightPressed = true;
    }
  } 
}

void keyReleased() {
  if (keyCode == UP) {
    //playerShip.upPressed = false;
  } else if (keyCode == DOWN) {
    //playerShip.downPressed = false;
  } else if (keyCode == LEFT) {
    playerShip.leftPressed = false;
  } else if (keyCode == RIGHT) {
    playerShip.rightPressed = false;
  }
}

void mousePressed() {
  if (start != null && start.mouseEnBoton1() == true) {
    obstaculosFrequency = 20;
    ran1 = 60;
    ran2 = 110;
    start = null;
    mp31.play();
  } else if (start != null && start.mouseEnBoton2() == true) {
    ran1 = 30;
    ran2 = 60;
    obstaculosFrequency = 140;
    start = null;
    mp32.play();
  } else if (end != null && end.mouseOverButton() == true) {
    resetGame();
  }
}

void resetGame() {
  obstaculos.clear();
  playerShip = new Ship();
  start = new StartScene();
  end = null;
}
