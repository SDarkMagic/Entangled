public void updateColor(DynamicActor player, DynamicActor entangled_player, Map environment, int currentFrame){
    int colliding;
    int entangledColliding;

    // Add gravity every frame if the level is a platforming level
    if (environment.type.equals("platform")){
      player.applyForce(GRAVITY);
      entangled_player.applyForce(GRAVITY);
    }

    // Check for collision on each player in their respective world area
    colliding = player.update(environment.mainObjects, environment.boundaries, currentFrame);
    entangledColliding = entangled_player.update(environment.subObjects, environment.boundaries, currentFrame);
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