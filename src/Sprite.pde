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
    change_x = 0;
    change_y = 0;
    mass = 0;
  }

  public Sprite(String filename, float scale){
    this(filename, scale, 0, 0);
  }

  public void display(){
    image(image, center_x, center_y, w, h);
  }

  public void update(ArrayList<Sprite> collisions){
    if(collisions.size() > 0){
      resolveCollision(this, collisions.get(0));
    }
    else {
      center_x += change_x;
      center_y += change_y;
    }
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
  public DynamicSprite(String filename, float scale, float x, float y, float mass){
    super(filename, scale, x, y);
    mass = mass;
  }

  public void update(ArrayList<Sprite> collisions){
    if(collisions.size() > 0){
      println("resolving collisions");
      resolveCollision(this, collisions.get(0));
    }
    else {
      center_x += change_x;
      center_y += change_y;
    }
  }
}