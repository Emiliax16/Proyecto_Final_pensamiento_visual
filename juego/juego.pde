import processing.sound.*;
SoundFile mp31, mp32;
Ship playerShip;
ArrayList < Obstaculos > obstaculos = new ArrayList < Obstaculos > ();
int obstaculosFrequency = 120; // LOWER == MORE OBSTACULOS
int segundos = 0;
int ran1, ran2;
int pos_x_arbol = 730;
int pos_y_arbol = -175;
int ancho_arbol = 140;
int alto_arbol = 175;
int opacidad = 0;
int chocar;
float volumen = 0.7;
StartScene start;
EndScene end;
PShape s;
PImage b;
PImage p;
PImage a;


void setup() {
    // fullScreen(P2D);
    size(800, 800);
    playerShip = new Ship();
    //frameRate(100);
    //points = 0;
    s = loadShape("data/calle.svg");
    b = loadImage("data/bicicleta.png");
    p = loadImage("data/piedra.png");
    a = loadImage("data/arbol.png");
    //noStroke();
    start = new StartScene();

    mp31 = new SoundFile(this, "relato_sofia.mp3");
    mp31.amp(volumen);
    mp32 = new SoundFile(this, "temp_file_2.mp3");
    mp32.amp(volumen);
}

void draw() {
    if (start != null) {
        start.drawStartScene();
    } else if (end != null) {
        end.drawEndScene();
        mp31.stop();
        mp32.stop();
    } else {
        shape(s, 0, 0, 800, 800);
        drawObstaculos();
        drawArbol();
        //fill(255, 0, 0);
        stroke(255);
        playerShip.drawShip();
        drawOpacidad();
        if (chocar == 1) {
            opacidad += 2;
        }

        checkCollision();
        if ((mp31.isPlaying() || mp32.isPlaying()) == false) {
            end = new EndScene();
        }

    }
}


void checkCollision() {
    chocar = 0;
    for (int i = 0; i < obstaculos.size(); i++) {
        Obstaculos a = obstaculos.get(i);
        if (a.checkCollision(playerShip) == true) {
            chocar = 1;
        }
    }
}


void drawObstaculos() {
    if (frameCount % obstaculosFrequency == 0) {
        obstaculos.add(new Obstaculos(random(ran1, ran2)));
    }
    for (int i = 0; i < obstaculos.size(); i++) {
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
    if (pos_y_arbol >= height + 150) {
        pos_y_arbol = -175;
    }
}

void drawOpacidad() {
    fill(0, 0, 0, opacidad);
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
    obstaculos.clear();
    playerShip = new Ship();
    start = new StartScene();
    end = null;
}