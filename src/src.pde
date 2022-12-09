static float MOVE_SPEED = 5;

//declare global variables
DynamicSprite player;
DynamicSprite entangled_player;
int currentFrame;
Actor divider;
Map environment;

void setup(){
  float playerMass = 0.025;
  size(1280, 1080);
  frameRate(60);
  imageMode(CENTER);
  currentFrame = 0;
  environment = new Map("maps/test.json");
  divider = new Actor(1.0, height/2, width/2, 3, width);
  player = new DynamicSprite("player.png", 1.0, environment.spawn.get("x"), environment.spawn.get("y"), playerMass);
  entangled_player = new DynamicSprite("player.png", 1.0, environment.spawn2.get("x"), environment.spawn2.get("y"), playerMass);
  println("environment.type: "+environment.type);
}

void draw(){
  currentFrame++;
  background(environment.backgroundColor);
  // Draw the screen divider
  strokeWeight(3);
  line(0, divider.center_y, divider.w, divider.center_y);
  for (Sprite object: environment.mainObjects){
    object.display();
  }
  // Add gravity every frame
  if (environment.type.equals("platform")){
    player.applyGravity(currentFrame);
  }
  // Make the second player object inherit the same velocity as the main one
  entangled_player.change_x = player.change_x;
  entangled_player.change_y = player.change_y;
  // Check for collision on each player in their respective world area
  player.update(checkCollisionList(player, environment.mainObjects), currentFrame);
  entangled_player.update(checkCollisionList(entangled_player, environment.subObjects), currentFrame);
  player.update(divider, currentFrame);
  entangled_player.update(divider, currentFrame);
  player.display();
  entangled_player.display();
  if (currentFrame == frameRate){
    currentFrame = 0;
  }
}

void keyPressed(){
// move character using 'a', 's', 'd', 'w'
  if (key == 'a'){
    player.change_x = 0 - MOVE_SPEED;
  }
  else if (key == 'd'){
    player.change_x = MOVE_SPEED;
  }
  else if (key == 'w'){
    player.change_y = 0 - MOVE_SPEED;
  }
  else if (key == 's'){
    player.change_y = MOVE_SPEED;
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
  }
  else if (key == 'w' || key == 's'){
    player.change_y = 0;
  }
}
