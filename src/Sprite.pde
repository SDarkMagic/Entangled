static float GRAVITY = 9.8;

// Abstract class for handling entities to make collision processing easier
public class Actor{
  float center_x, center_y;
  float w, h;

  public Actor(float scale, float x, float y, float sizeX, float sizeY){
    center_x = x;
    center_y = y;
    w = sizeX * scale;
    h = sizeY * scale;
  }

  public Actor(float scale, float x, float y){
    this(scale, x, y, 0, 0);
  }

  // Simple methods for getting sprite basic sprite boundary information
  public float getLeft(){
    return center_x - w/2;
  }

  public float getRight(){
    return center_x + w/2;
  }

  public float getTop(){
    return center_y - h/2;
  }

  public float getBottom(){
    return center_y + h/2;
  }
   // Methods for moving sprite edges
  public void setLeft(float left){
    center_x = left + w/2;
  }

  public void setRight(float right){
    center_x = right - w/2;
  }

  public void setTop(float top){
    center_y = top + w/2;
  }

  public void setBottom(float bottom){
    center_y = bottom - w/2;
  }
}

public class Sprite extends Actor{
  PImage image;
  float change_x;
  float change_y;

  public Sprite(String filename, float scale, float x, float y){
    image = loadImage(filename);
    change_x = 0;
    change_y = 0;
    Actor(scale, x, y, image.width, image.height);
  }

  public Sprite(String filename, float scale){
    this(filename, scale, 0, 0);
  }

  public void display(){
    image(image, center_x, center_y, w, h);
  }
}

public class DynamicSprite extends Sprite{
  float mass;

  public DynamicSprite(String filename, float scale, float x, float y, float objectMass){
    super(filename, scale, x, y);
    mass = objectMass;
  }

  public void update(ArrayList<Sprite> collisions, int frame){
    if(collisions.size() > 0){
      resolveCollision(this, collisions.get(0));
    }
    else {
      center_x += change_x;
      center_y += change_y;
    }
  }

  public void update(Actor collisions, int frame){
    if(collisions.size() > 0){
      resolveCollision(this, collisions);
    }
    else {
      center_x += change_x;
      center_y += change_y;
    }
  }

  public void applyGravity(int currentFrame){
      change_y += (mass * GRAVITY * currentFrame) / frameRate; // Multiply the gravitational velocity of the object by the current frame then divide by the total framerate to get the velocity in seconds
  }
  public void applyForce(int currentFrame, float force){
      change_y += (mass * force * currentFrame) / frameRate; // Multiply the gravitational velocity of the object by the current frame then divide by the total framerate to get the velocity in seconds
  }
}