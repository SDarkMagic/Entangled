/*
Current code will create a window for the game and load the data from the file 'test.json' to create the initial map.
W A S & D will move the green cube, which is the placeholder for the player sprite. Pressing Space will add vertical velocity to the player and cause a jump action
Currently, there is an odd issue that occurs if the player is colliding with another object and attempts to move in another direction simultaneously where
it will snap the player to a corner of the collided object. I plan on adding a menu system to select levels from, as well as text to explain how the various mechanics work
and how they relate to quantum entanglement. Additionally, I will be adding more levels as well as other sprite types that have various abilities.
*/

//declare global variables
static float MOVE_SPEED = 5;
static float PLAYER_MASS = 1.5;
static float GRAVITY = 9.8;

DynamicActor player;
DynamicActor entangled_player;
boolean onGround;
boolean entangled_onGround;
int currentFrame;
boolean inLevel;
MainMenu menu;
Actor divider;
Actor floor;
Map environment;
ArrayList<Actor> verticalBoundaries;
String levels[] = new String[3];
int currentLevel;
boolean levelComplete;
PostLevelMenu postLevel;

void setup(){
  menu = new MainMenu(this, "Entangled", "A Game About Quantum Entanglement");
  postLevel = new PostLevelMenu(this);
  inLevel = false;
  levelComplete = false;
  verticalBoundaries = new ArrayList<Actor>();
  size(displayWidth, displayHeight);
  frameRate(60);
  imageMode(CENTER);
  textAlign(CENTER);
  currentFrame = 0;
  currentLevel = 0;
  levels[0] = "test";
  levels[1] = "level-2";
  menu.display();
}

public void nextLevel(){
  //noLoop();
  postLevel.display();
  currentLevel++;
  inLevel = false;
  if (postLevel.next.isPressed()){
    environment = postLevel.loadLevel(levels[currentLevel]);
    player = new DynamicActor("player.png", 0.75, environment.spawn.get("x"), environment.spawn.get("y"), PLAYER_MASS);
    entangled_player = new DynamicActor("player_entangled.png", 0.75, environment.spawn2.get("x"), environment.spawn2.get("y") + divider.center_y, PLAYER_MASS);
    inLevel = true;
  }
  else if(postLevel.quit.isPressed()){
    exit();
  }
  //loop();
  levelComplete = false;
}

void draw(){
  if (!menu.play.isPressed() && !inLevel){
  }
  else if ((menu.play.isPressed() || levelComplete) && !inLevel){
    environment = menu.loadLevel(levels[currentLevel]);
    divider = new Actor(1.0, width/2, height/2, width, 3);
    floor = new Actor(1.0, width/2, height - 2, width, 3);
    verticalBoundaries.add(divider);
    verticalBoundaries.add(floor);
    player = new DynamicActor("player.png", 0.75, environment.spawn.get("x"), environment.spawn.get("y"), PLAYER_MASS);
    entangled_player = new DynamicActor("player_entangled.png", 0.75, environment.spawn2.get("x"), environment.spawn2.get("y") + divider.center_y, PLAYER_MASS);
    for (Actor object: environment.subObjects){
      // Offset the center of the sub sprites to make duplicating layouts easier
      object.center_y += divider.center_y;
    }
    menu.hide(menu.play);
    inLevel = true;
  }
  else if (inLevel){
    postLevel.hideMenu();
    textSize(32);
    currentFrame++;
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
    onGround = player.update(checkCollisionList(player, environment.mainObjects), verticalBoundaries, currentFrame);
    entangled_onGround = entangled_player.update(checkCollisionList(entangled_player, environment.subObjects), verticalBoundaries, currentFrame);
    player.display();
    entangled_player.display();
    text(environment.description, width/2, 75); // Draw the text after everything else so it renders on top
    if (currentFrame == frameRate){
      currentFrame = 0;
    }
    if (isColliding(player, entangled_player)){
      setup();
    }
  }
}

void keyPressed(){
  if (inLevel){
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
        if (onGround){
          player.change_y = -10;
          onGround = false;
        }
        if (entangled_onGround){
          entangled_player.change_y = -10;
          entangled_onGround = false;
        }
      }
    }
    else if (!environment.movementEnabled && environment.type == "color_match"){
      if (key == ' '){
        // Rotate the player's color
      }
    }
  }
  return;
}

void keyReleased(){
  if (inLevel){
  // if key is released, set change_x, change_y back to 0
  if (key == 'a' || key == 'd'){
    player.change_x = 0;
    entangled_player.change_x = 0;
  }
  else if (key == 'w' || key == 's'){
    player.change_y = 0;
    entangled_player.change_y = 0;
  }
  }
}
