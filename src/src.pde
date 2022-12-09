static float MOVE_SPEED = 5;

//declare global variables
DynamicSprite player;
DynamicSprite entangled_player;
int currentFrame;
Actor divider;
Actor floor;
Map environment;
ArrayList<Actor> verticalBoundaries;

void setup(){
  verticalBoundaries = new ArrayList<Actor>();
  float playerMass = 0.025;
  size(1280, 1080);
  frameRate(60);
  imageMode(CENTER);
  currentFrame = 0;
  environment = new Map("maps/test.json");
  divider = new Actor(1.0, width/2, height/2, width, 3);
  floor = new Actor(1.0, width/2, height - 2, width, 3);
  verticalBoundaries.add(divider);
  verticalBoundaries.add(floor);
  player = new DynamicSprite("player.png", 1.0, environment.spawn.get("x"), environment.spawn.get("y"), playerMass);
  entangled_player = new DynamicSprite("player.png", 1.0, environment.spawn2.get("x"), environment.spawn2.get("y") + divider.center_y, playerMass);
  for (Sprite object: environment.subObjects){
    // Offset the center of the sub sprites so to make duplicating layouts easier
    object.center_y += divider.center_y;
  }
}

void draw(){
  currentFrame++;
  background(environment.backgroundColor);
  // Draw the screen divider
  strokeWeight(3);
  for (Actor boundary: verticalBoundaries){
  line(0, boundary.center_y, boundary.w, boundary.center_y);
  }
  for (Sprite object: environment.mainObjects){
    object.display();
  }
  for (Sprite object: environment.subObjects){
    object.display();
  }
  // Add gravity every frame if the level is a platforming level
  if (environment.type.equals("platform")){
    player.applyGravity(currentFrame);
    entangled_player.applyGravity(currentFrame);
  }
  // Make the second player object inherit the same velocity as the main one
  //entangled_player.change_x = player.change_x;
  //entangled_player.change_y = player.change_y;
  // Check for collision on each player in their respective world area
  player.update(checkCollisionList(player, environment.mainObjects), verticalBoundaries, currentFrame);
  entangled_player.update(checkCollisionList(entangled_player, environment.subObjects), verticalBoundaries, currentFrame);
  player.display();
  entangled_player.display();
  if (currentFrame == frameRate){
    currentFrame = 0;
  }
}

void keyPressed(){
// move character using 'a', 's', 'd', 'w'
  if (key == 'a'){
    player.change_x = - MOVE_SPEED;
    entangled_player.change_x = - MOVE_SPEED;
  }
  else if (key == 'd'){
    player.change_x = MOVE_SPEED;
    entangled_player.change_x = MOVE_SPEED;
  }
  else if (key == 'w'){
    player.change_y = 0 - MOVE_SPEED;
    entangled_player.change_y = - MOVE_SPEED;
  }
  else if (key == 's'){
    player.change_y = MOVE_SPEED;
    entangled_player.change_y = MOVE_SPEED;
  }
  // Space key is different as it is used for jump. This requires a more complex function to calculate gravity and other forces
  else if (key == ' '){
    player.change_y = -10;
  }
  return;
}

void keyReleased(){
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
