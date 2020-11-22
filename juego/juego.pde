Ship playerShip;

ArrayList<Obstaculos> obstaculos = new ArrayList<Obstaculos>();
int obstaculosFrequency = 10; // LOWER == MORE OBSTACULOS

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
}

void draw() {

  if (end != null) {
    end.drawEndScene();
  } else { 
    shape(s, 0, 0, 800, 800);
    //drawStar();

    drawObstaculos();
    fill(255, 0, 0);
    stroke(255);
    //drawBullet();
    playerShip.drawShip();

    //stroke(255);
    //fill(255);
    //textSize(30);
    //text("Points: " + points, 50, 50);

    checkCollision();
  }
}

//void drawBullet() {
//  for (int i = 0; i<bullets.size(); i++) {
    //i is every number from 0 to the size of the bullet array
    //println(bullets.get(i).x);
//    bullets.get(i).drawBullet();
//  }
//}

void checkCollision() {
  for (int i = 0; i < obstaculos.size(); i++) {
    Obstaculos a = obstaculos.get(i);
    if (a.checkCollision(playerShip) == true) {
      end = new EndScene();
    }
    //for (int b = 0; b < bullets.size(); b++) {
      //Bullet bullet = bullets.get(b);
      //if (a.checkCollision(bullet) == true) {
        //set up removal of bullet and astroid

        //points++;

        //obstaculos.remove(a);
        //bullets.remove(bullet);
        //i--;
        //b--;
     // }
   // }
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
      //points--;
    }
  }
  //prinln(obstaculos.size());
}

// void drawStar() {
//   strokeWeight(8);
//   stroke(255);
//   if (frameCount % frequency == 0) {
//     Star myStar = new Star();
//     stars.add(myStar);
//   }
//   for (int i = 0; i<stars.size(); i++) {
//     Star currentStar = stars.get(i);
//     currentStar.drawStar();
//   }
// }

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
  } else if (key == ' ') {
    Bullet b = new Bullet(playerShip);
    //bullets.add(b);

    //if (bullet == null) {
    //bullet = new Bullet(playShip);
    //}

    //Assume we're in the right location
    //bullet = null;
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
  // stars.clear();
  //bullets.clear();
  obstaculos.clear();
  playerShip = new Ship();
  end = null;
  //points = 0;
}
