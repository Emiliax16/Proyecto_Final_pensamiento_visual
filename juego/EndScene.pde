class EndScene {
  String gameOverText, buttonText, pointsText;
  int buttonX, buttonY, buttonW, buttonH;


  EndScene() {
    this.gameOverText = "Todos partimos con la misma bicicleta,\npero nuestros caminos son distintos.";
    this.buttonText = "Volver al Menú";
    //this.pointsText = "Your final Score is " + points;
    this.pointsText = "";
    this.buttonW = 350;
    this.buttonH = 70;
    this.buttonX = width/2 - this.buttonW/2;
    this.buttonY = height - this.buttonH*2;
  }

  void drawEndScene() {
    //OVERLAY
    fill(#34495E);
    image(fondo_final,0,0,width, height);
    rect(buttonX, buttonY, buttonW, buttonH);
    rect(-5,100,width+5,140); 

    //TEXT
    stroke(0);
    fill(225);
    textSize(40);
    text(this.gameOverText, 30, 150);


    //BUTTON
    fill(#34495E);
    stroke(200);
    rect(buttonX, buttonY, buttonW, buttonH);
    fill(200);
    text(buttonText, buttonX+45, buttonY+47);
    
  }

  boolean mouseOverButton() {
    return (mouseX > buttonX 
      && mouseX < buttonX + buttonW
      && mouseY > buttonY
      && mouseY < buttonY + buttonH);
  }
}
