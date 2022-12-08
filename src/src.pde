static float MOVE_SPEED = 5;

//declare global variables
DynamicSprite player;
int currentFrame;
Map environment;

void setup(){
  size(800, 600);
  frameRate(60);
  imageMode(CENTER);
  currentFrame = 0;
  environment = new Map("maps/test.json");
  player = new DynamicSprite("player.png", 1.0, environment.spawn.get("x"), environment.spawn.get("y"), 1.0);
  println("environment.type: "+environment.type);
}

void draw(){
  currentFrame++;
  background(environment.backgroundColor);
  for (Sprite object: environment.objects){
    object.display();
  }
  // Add gravity every frame
  if (environment.type.equals("platform")){
    player.applyGravity(currentFrame);
  }
  player.update(checkCollisionList(player, environment.objects), currentFrame);
  player.display();
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
    println("key pressed");
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
