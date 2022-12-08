static float GRAVITY = 9.8;

public class Sprite{
  PImage image;
  float center_x, center_y;
  float change_x, change_y;
  float w, h;
  float mass;

  public Sprite(String filename, float scale, float x, float y){
    image = loadImage(filename);
    w = image.width * scale;
    h = image.height * scale;
    center_x = x;
    center_y = y;
    mass = 0;
  }

  public Sprite(String filename, float scale){
    this(filename, scale, 0, 0);
  }

  public void display(){
    image(image, center_x, center_y, w, h);
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

public class DynamicSprite extends Sprite{
  float mass;
  float change_x;
  float change_y;

  public DynamicSprite(String filename, float scale, float x, float y, float objectMass){
    super(filename, scale, x, y);
    change_x = 0;
    change_y = 0;
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

  public void applyGravity(int currentFrame){
      change_y += (mass * GRAVITY * currentFrame) / frameRate; // Multiply the gravitational velocity of the object by the current frame then divide by the total framerate to get the velocity in seconds
  }
}