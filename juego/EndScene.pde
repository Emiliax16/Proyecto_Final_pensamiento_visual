class EndScene {
  String gameOverText, buttonText, pointsText;
  int buttonX, buttonY, buttonW, buttonH;


  EndScene() {
    this.gameOverText = "Todos partimos con la misma bicicleta,\npero nuestros caminos son distintos.";
    this.buttonText = "Reintentar";
    //this.pointsText = "Your final Score is " + points;
    this.pointsText = "";
    this.buttonW = 200;
    this.buttonH = 100;
    this.buttonX = width/2 - this.buttonW/2;
    this.buttonY = height/2 - this.buttonH/2;
  }

  void drawEndScene() {
    //OVERLAY
    fill(#34495E);
    rect(0, 0, width, height);
    rect(buttonX, buttonY, buttonW, buttonH);

    //TEXT
    stroke(255);
    fill(255);
    textSize(30);
    text(this.gameOverText, 120, 150);


    //BUTTON
    fill(0);
    stroke(200);
    rect(buttonX, buttonY, buttonW, buttonH);
    fill(200);
    text(buttonText, buttonX+25, buttonY+70);
    
  }

  boolean mouseOverButton() {
    return (mouseX > buttonX 
      && mouseX < buttonX + buttonW
      && mouseY > buttonY
      && mouseY < buttonY + buttonH);
  }
}
