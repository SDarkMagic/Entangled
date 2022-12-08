static float MOVE_SPEED = 5;

//declare global variables
Sprite player;
float gravity = 9.8;
int currentFrame = 0;
Map defaultMapData;
ArrayList<Sprite> environment;

void setup(){
  size(800, 600);
  frameRate(60);
  imageMode(CENTER);
  player = new Sprite("player.png", 1.0, width/2, height/2);
  defaultMapData = new Map("maps/test.json");
  environment = defaultMapData.objects;
  player.mass = 1.0;
}

void draw(){
  currentFrame++;
  background(defaultMapData.backgroundColor);
  for (Sprite object: environment){
    object.display();
  }
  // Add gravity every frame
  player.change_y += (player.mass * gravity * currentFrame) / frameRate; // Multiply the gravitational velocity of the object by the current frame then divide by the total framerate to get the velocity in seconds
  player.update(checkCollisionList(player, environment));
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
