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
int colliding;
int entangledColliding;
int currentFrame;
boolean inLevel;
MainMenu menu;
Actor divider;
Actor floor;
Map environment;
String levels[] = new String[3];
int currentLevel;
boolean levelComplete;
PostLevelMenu postLevel;

void setup(){
  menu = new MainMenu(this, "Entangled", "A Game About Quantum Entanglement");
  postLevel = new PostLevelMenu(this);
  inLevel = false;
  levelComplete = false;
  fullScreen();
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
  println(postLevel.next.isPressed());
  if (postLevel.next.isPressed()){
    environment = postLevel.loadLevel(levels[currentLevel]);
    player = new DynamicActor("player.png", 0.75, environment.spawn.get("x"), environment.spawn.get("y"), PLAYER_MASS);
    entangled_player = new DynamicActor("player_entangled.png", 0.75, environment.spawn2.get("x"), environment.spawn2.get("y") + divider.center_y, PLAYER_MASS);
    inLevel = true;
  }
  if(postLevel.quit.isPressed()){
    exit();
  }
  //loop();
  levelComplete = false;
}

void draw(){
  if (!menu.play.isPressed() && !inLevel){
  }
  if ((menu.play.isPressed() || levelComplete) && !inLevel){
    environment = menu.loadLevel(levels[currentLevel]);
    divider = new Actor(1.0, width/2, height/2, width, 3);
    floor = new Actor(1.0, width/2, height - 2, width, 3);
    player = new DynamicActor("player.png", 0.75, environment.spawn.get("x"), environment.spawn.get("y"), PLAYER_MASS);
    entangled_player = new DynamicActor("player_entangled.png", 0.75, environment.spawn2.get("x"), environment.spawn2.get("y") + divider.center_y, PLAYER_MASS);
    for (Actor object: environment.subObjects){
      // Offset the center of the sub sprites to make duplicating layouts easier
      object.center_y += divider.center_y;
    }
    menu.hide(menu.play);
    inLevel = true;
  }
  if (inLevel){
    currentFrame++;
    int[] collisions = updatePhysics(player, entangled_player, environment, currentFrame);
    colliding = collisions[0];
    entangledColliding = collisions[1];
    if (currentFrame == frameRate){
      currentFrame = 0;
    }
  }
}

void keyPressed(){
  if (inLevel){
    if (true){
      physicsController(player, entangled_player, environment, MOVE_SPEED);
    }
    if (!environment.movementEnabled && environment.type == "color_match"){
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
  if (key == 'w' || key == 's'){
    player.change_y = 0;
    entangled_player.change_y = 0;
  }
  }
}
