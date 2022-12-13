public int[] updatePhysics(DynamicActor player, DynamicActor entangled_player, ArrayList<Actor> verticalBoundaries, Map environment, int currentFrame){
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
    // Add gravity every frame if the level is a platforming level
    if (environment.type.equals("platform")){
      player.applyForce(GRAVITY);
      entangled_player.applyForce(GRAVITY);
    }

    // Check for collision on each player in their respective world area
    colliding = player.update(environment.mainObjects, verticalBoundaries, currentFrame);
    entangledColliding = entangled_player.update(environment.subObjects, verticalBoundaries, currentFrame);
    player.display();
    entangled_player.display();
    text(environment.description, width/2, 75); // Draw the text after everything else so it renders on top
    if (colliding == 2 && entangledColliding == 2){
      nextLevel();
    }
    if (player.isColliding(entangled_player)){
      setup();
    }
    int[] collisions = {colliding, entangledColliding};
    return collisions;
}

public void physicsController(DynamicActor player, DynamicActor entangled_player, Map environment, float MOVE_SPEED){
    if (environment.movementEnabled){
    // move character using 'a', 's', 'd', 'w'
      if (key == 'a'){
        player.change_x = - MOVE_SPEED;
        entangled_player.change_x = - MOVE_SPEED;
      }
      else if (key == 'd'){
        player.change_x = MOVE_SPEED;
        entangled_player.change_x = MOVE_SPEED;
      }
      else if (key == 'w' && !environment.type.equals("platform")){
        player.change_y = 0 - MOVE_SPEED;
        entangled_player.change_y = - MOVE_SPEED;
      }
      else if (key == 's'){
        player.change_y = MOVE_SPEED;
        entangled_player.change_y = MOVE_SPEED;
      }
      // Space key is different as it is used for jump. This requires a more complex function to calculate gravity and other forces
      else if (key == ' ' && environment.type.equals("platform")){
        if (colliding >= 1){
          player.change_y = -10;
          colliding = 0;
        }
        if (entangledColliding >= 1){
          entangled_player.change_y = -10;
          entangledColliding = 0;
        }
      }
    }
}