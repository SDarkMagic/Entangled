final static float MOVE_SPEED = 5;

//declare global variables
Sprite s1, s2;
float gravity = 9.8;
int currentFrame = 0;
ArrayList<Sprite> environment = new ArrayList<Sprite>();

void setup(){
  size(800, 600);
  frameRate(60);
  imageMode(CENTER);
  s1 = new Sprite("player.png", 1.0, width/2, height/2);
  s2 = new Sprite("crate.png", 0.5, width/2, (height/2) + 300);
  environment.add(s2);
  s1.mass = 1.0;
}

void draw(){
  currentFrame++;
  background(255);
  s2.display();
  // Add gravity every frame
  s1.change_y = (s1.mass * gravity * currentFrame) / frameRate; // Multiply the gravitational velocity of the object by the current frame then divide by the total framerate to get the velocity in seconds
  s1.update(checkCollisionList(s1, environment));
  s1.display();
  if (currentFrame == frameRate){
    currentFrame = 0;
  }
}

void keyPressed(){
// move character using 'a', 's', 'd', 'w'
  if (key == 'a'){
    s1.change_x = 0 - MOVE_SPEED;
  }
  else if (key == 'd'){
    s1.change_x = MOVE_SPEED;
  }
  else if (key == 'w'){
    s1.change_y = 0 - MOVE_SPEED;
  }
  else if (key == 's'){
    s1.change_y = MOVE_SPEED;
  }
  // Space key is different as it is used for jump. This requires a more complex function to calculate gravity and other forces
  else if (key == ' '){

  }
  return;
}

void keyReleased(){
// if key is released, set change_x, change_y back to 0
  if (key == 'a' || key == 'd'){
    s1.change_x = 0;
  }
  else if (key == 'w' || key == 's'){
    s1.change_y = 0;
  }
}
