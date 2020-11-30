import processing.sound.*;
SoundFile mp31, mp32;
Ship playerShip;
ArrayList<Obstaculos> obstaculos = new ArrayList<Obstaculos> ();
int obstaculosFrequency = 120; // LOWER == MORE OBSTACULOS
int segs_dsps = 0;
int ran1, ran2;
int pos_x_arbol = 730;
int pos_y_arbol = -150;
int ancho_arbol = 120;
int alto_arbol = 150;
int opacidad = 0;
int opacidad2 = 0;
int chocar;
float volumen = 0.7;
float j1_tiempo;
StartScene start;
EndScene end;
PImage s;
PImage s2;
PImage b;
PImage b2;
PImage p;
PImage a;
PImage g;
PImage fondo_portada;
PImage fondo_final;
boolean j1 = true;
int jug;

void setup() {
  // fullScreen(P2D);
  size(800, 800);
  playerShip = new Ship();
  //frameRate(100);
  //points = 0;
  s = loadImage("calle2.png"); //FONDO CAMPO!!!
  s2 = loadImage("fondito_tierra.png"); //FONDO CIUDAD!!!
  b = loadImage("bicicleta_m.png");
  b2 = loadImage("bicicleta_h.png");
  p = loadImage("rocapng2.png");
  a = loadImage("arbolpng.png");
  g = loadImage("grieta2.png");
  fondo_portada = loadImage("fondo_bici.jpg");
  //imagen recuperada de https://viajesenbicicletas.com/intente-ir-a-trabajar-en-bicicleta-todos-los-dias-durante-una-semana-y-esto-es-lo-que-sucedio/
  fondo_final = loadImage("fondo_sala.jpg");
  //imagen recuperada de https://www.diarioconcepcion.cl/ciudad/2020/06/20/sigue-la-incertidumbre-por-el-retorno-a-clases-presenciales.html
  //noStroke();
  start = new StartScene();

  //mp31 = new SoundFile(this, "relato_sofia.mp3");
  mp31 = new SoundFile(this, "professional.mp3");
  mp31.amp(volumen);
  //mp32 = new SoundFile(this, "temp_file_2.mp3");
  mp32 = new SoundFile(this, "professional.mp3");
  mp32.amp(volumen);
}

void draw() {
  if (start != null) {
    start.drawStartScene();
  } else if (end != null) {
    end.drawEndScene();
    mp31.stop();
    mp32.stop();
  } else if (jug == 1) {
    image(s, 0, 0, 800, 800);
    drawArbol();
    drawObstaculos();
    //fill(255, 0, 0);
    stroke(255);
    playerShip.drawShip();
    drawOpacidad();
    if (chocar == 1) {
      opacidad += 2;
    }

    checkCollision();
    if ((mp31.isPlaying() || mp32.isPlaying()) == false) {
      if (j1) {
        segs_dsps = millis() / 1000;
        j1 = false;
      };
      opacidad2 += 2;
      drawBlanco();
      if ((millis() / 1000) - segs_dsps > 3) {
        end = new EndScene();
      }
    }

  } else if (jug == 2) {
    image(s2, 0, 0, 800, 800);
    //drawArbol();                    //INSERTAR AQUÍ LA FUNCIÓN PARA DIBUJAR LAS LÍNEAS
    drawObstaculos();
    //fill(255, 0, 0);
    stroke(255);
    playerShip.drawShip();
    drawOpacidad();
    if (chocar == 1) {
      opacidad += 2;
    }

    checkCollision();
    if ((mp31.isPlaying() || mp32.isPlaying()) == false) {
      if (j1) {
        segs_dsps = millis() / 1000;
        j1 = false;
      };
      opacidad2 += 2;
      drawBlanco();
      if ((millis() / 1000) - segs_dsps > 3) {
        end = new EndScene();
      }
    }

  }
}

void checkCollision() {
  chocar = 0;
  for (int i = 0; i<obstaculos.size(); i++) {
    Obstaculos a = obstaculos.get(i);
    if (a.checkCollision(playerShip) == true) {
      chocar = 1;
      image(g, a.x - 50, a.y - 10, 90, 90);
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

void drawArbol() {
  image(a, pos_x_arbol, pos_y_arbol, ancho_arbol, alto_arbol);
  pos_y_arbol = pos_y_arbol + 2;
  if (pos_y_arbol >= height + 120) {
    pos_y_arbol = -150;
  }
}

void drawOpacidad() {
  fill(0, 0, 0, opacidad);
  rect(0, 0, width, height);
}

void drawBlanco() {
  fill(255, 255, 255, opacidad2);
  rect(0, 0, width, height);
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
  j1 = true;
  opacidad = 0;
  opacidad2 = 0;
  obstaculos.clear();
  playerShip = new Ship();
  start = new StartScene();
  end = null;
}
