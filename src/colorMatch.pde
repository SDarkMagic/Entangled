public void updateColor(DynamicActor player, DynamicActor entangled_player, Map environment, int currentFrame){
    int colliding;
    int entangledColliding;
    environment.display(postLevel);
    // Check for collision on each player in their respective world area
    colliding = player.update(environment.mainDynamicObjects, environment.boundaries, currentFrame);
    entangledColliding = entangled_player.update(environment.subDynamicObjects, environment.boundaries, currentFrame);
    player.display();
    entangled_player.display();
    text(environment.description, width/2, 75); // Draw the text after everything else so it renders on top
    if (colliding == 2 && entangledColliding == 2){
      nextLevel();
    }
    if (colliding == 3 || entangledColliding == 3){
      restartLevel();
    }
    if (player.isColliding(entangled_player)){
      setup();
    }
    int[] collisions = {colliding, entangledColliding};
}

public void colorController(DynamicActor player, DynamicActor entangled_player){
  int newColor;
    // Change the player color depending on the pressed key
    switch(key){
      case 'a': newColor = 0xffdb11ed;
                break;
      case 'd': newColor = 0xff11d7ed;
                break;
      case 'w': newColor = 0xffff0000;
                break;
      case 's': newColor = 0xfffff700;
                break;
      default: newColor = 0xffffffff;
               break;
    }
    player.baseColor = newColor;
    entangled_player.baseColor = newColor;
}

public void restartLevel(){
  //noLoop();
  retryLevel.display();
  inLevel = false;
  println(retryLevel.retry.isPressed());
  if (retryLevel.retry.isPressed()){
    environment = retryLevel.loadLevel(levels[currentLevel]);
    player = new DynamicActor("player.png", 0.75, environment.spawn.get("x"), environment.spawn.get("y"), PLAYER_MASS);
    entangled_player = new DynamicActor("player.png", 0.75, environment.spawn2.get("x"), environment.spawn2.get("y") + divider.center_y, PLAYER_MASS);
    inLevel = true;
    retryLevel.hideMenu();
  }
  if(retryLevel.quit.isPressed()){
    exit();
  }
  //loop();
  levelComplete = false;
}