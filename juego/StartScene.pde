class StartScene {
  String startText, startText2, button1Text, button2Text, pointsText;
  int buttonX, buttonY, button2X, button2Y, buttonW, buttonH;


  StartScene() {
    this.startText = "Realidades en la";
    this.startText2 = "Educación";
    this.button1Text = "Sofía Leon";
    this.button2Text = "Matías Barra";
    this.buttonW = 300;
    this.buttonH = 75;
    this.buttonX = width/2 - this.buttonW/2-200;
    this.buttonY = height/2 - this.buttonH/2;
    this.button2X = width/2 - this.buttonW/2+200;
    this.button2Y = height/2 - this.buttonH/2;
  }

  void drawStartScene() {
    //Overlay
    fill(#488599);
    image(fondo_portada, 0, 0, width, height);
    rect(buttonX, buttonY, buttonW, buttonH);
    rect(button2X, button2Y, buttonW, buttonH);

    //Título
    stroke(255);
    fill(0);
    textSize(60);
    text(this.startText, width/5, 150);
    text(this.startText2, width/3, 250);
    
    
    // BOTONES
    textSize(30);
    
    //BOTON 1
    fill(0);
    stroke(200);
    rect(buttonX, buttonY, buttonW, buttonH);
    fill(200);
    text(button1Text, buttonX+70, buttonY+50);
    
    //BUTTON2
    fill(0);
    stroke(200);
    rect(button2X, button2Y, buttonW, buttonH);
    fill(200);
    text(button2Text, button2X+55, button2Y+50);
  }

  boolean mouseEnBoton1() {
    jug = 1;
    return ((mouseX > buttonX 
      && mouseX < buttonX + buttonW
      && mouseY > buttonY
      && mouseY < buttonY + buttonH
      ));
  }
  boolean mouseEnBoton2() {
    jug = 2;
    return ((mouseX > button2X 
      && mouseX < button2X + buttonW
      && mouseY > button2Y
      && mouseY < button2Y + buttonH
      ));
  }
}
