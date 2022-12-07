final static float MOVE_SPEED = 5;

//declare global variables
Sprite s1;
float gravity = 9.8;
ArrayList<Sprite> environment = new ArrayList<Sprite>();

//initialize them in setup().
void setup(){
  size(800, 600);
  imageMode(CENTER);
  // width = 800, height = 600 (reserved variables for window dimensions)
  s1 = new Sprite("player.png", 1.0, width/2, height/2);
  s1.mass = 1.0;
}

// modify and update them in draw().
void draw(){
  background(255);
  s1.update();
  if(checkCollisionList(s1, environment).size() == 0){
    // Only move the character if they aren't colliding with anything
    s1.display();
  }
}

void keyPressed(){
// move character using 'a', 's', 'd', 'w'. Also use MOVE_SPEED above.
// use key instead of keyCode
  if (key == 'a'){
    s1.change_x = 0 - MOVE_SPEED;
  }
  else if (key == 'd') {
    s1.change_x = MOVE_SPEED;
  }
  else if (key == 'w') {
    s1.change_y = 0 - MOVE_SPEED;
  }
  else if (key == 's') {
    s1.change_y = MOVE_SPEED;
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
