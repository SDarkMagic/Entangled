public int[] updateColor(DynamicActor player, DynamicActor entangled_player, ArrayList<Actor> verticalBoundaries, Map environment, int currentFrame){
    int colliding;
    int entangledColliding;
    postLevel.hideMenu();
    textSize(32);
    background(environment.backgroundColor);
    // Draw the screen divider
    strokeWeight(3);
    for (Actor boundary: verticalBoundaries){
      line(0, boundary.center_y, boundary.w, boundary.center_y);
    }
    for (Actor object: environment.mainObjects){
      object.display();
    }
    for (Actor object: environment.subObjects){
      object.display();
    }

    // Check for collision on each player in their respective world area
    colliding = player.update(checkCollisionList(player, environment.mainObjects), verticalBoundaries, currentFrame);
    entangledColliding = entangled_player.update(checkCollisionList(entangled_player, environment.subObjects), verticalBoundaries, currentFrame);
    player.display();
    entangled_player.display();
    text(environment.description, width/2, 75); // Draw the text after everything else so it renders on top
    if (colliding == 2 && entangledColliding == 2){
      nextLevel();
    }
    if (isColliding(player, entangled_player)){
      setup();
    }
    int[] collisions = {colliding, entangledColliding};
    return collisions;
}

public void colorController(DynamicActor player, DynamicActor entangled_player, Map environment, float MOVE_SPEED){
    // Change the player color depending on the pressed key
    if (key == 'a'){
    }
    else if (key == 'd'){

    }
    else if (key == 'w' && !environment.type.equals("platform")){

    }
    else if (key == 's'){

    }
}