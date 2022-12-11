static float GRAVITY = 9.8;

public class Sprite extends Actor{
  PImage image;
  float change_x;
  float change_y;

  public Sprite(String filename, float scale, float x, float y){
    super();
    image = loadImage(filename);
    change_x = 0;
    change_y = 0;
    center_x = x;
    center_y = y;
    w = image.width * scale;
    h = image.height * scale;
  }

  public Sprite(String filename, float scale){
    this(filename, scale, 0, 0);
  }

  public Sprite(float scale, float x, float y, float w, float h, int rgb){
    super(scale, x, y, w, h, rgb);
  }

  public void display(){
    image(image, center_x, center_y, w, h);
  }
}

// Sprite that can handle movement and collision
public class DynamicSprite extends Sprite{
  float mass;

  public DynamicSprite(String filename, float scale, float x, float y, float objectMass){
    super(filename, scale, x, y);
    mass = objectMass;
  }

  public DynamicSprite(float scale, float x, float y, float w, float h, int rgb, float objectMass){
    super(scale, x, y, w, h, rgb);
    mass = objectMass;
  }

  public boolean update(ArrayList<Sprite> collisions, ArrayList<Actor> verticalBounds, int frame){
    boolean colliding = ensureInBounds(this, verticalBounds);
    if(collisions.size() > 0){
      resolveCollision(this, collisions.get(0));
      colliding = true;
    }
    else {
      center_x += change_x;
      center_y += change_y;
    }
    return colliding;
  }

  public void applyGravity(){
      change_y += (mass * GRAVITY) / frameRate; // Multiply the gravitational velocity of the object by its mass then divide by the total framerate to get the velocity in seconds
  }
  public void applyForce(float force){
      change_y += (mass * force) / frameRate; // Multiply the gravitational velocity of the object by the current frame then divide by the total framerate to get the velocity in seconds
  }
}
