static float GRAVITY = 9.8;

// Abstract class for handling entities to make collision processing easier
public class Actor{
  float center_x, center_y;
  float w, h;
  int baseColor;
  float thickness;

  public Actor(float scale, float x, float y, float sizeX, float sizeY, int rgb, float strokeThickness){
    center_x = x;
    center_y = y;
    w = sizeX * scale;
    h = sizeY * scale;
    baseColor = rgb;
    thickness = strokeThickness;
  }

  public Actor(float scale, float x, float y, float sizeX, float sizeY){
    this(scale, x, y, sizeX, sizeY, 0, 3);
  }

  public Actor(float scale, float x, float y){
    this(scale, x, y, 0, 0, 0);
  }

  public Actor(){}

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

  public void display(){
    strokeWeight();
    line(center_x - w/2, center_y - h/2, w, h);
  }
}

// Simple extension of the actor class that is capable of being repositioned each frame and detecting collision
public class DynamicActor extends Actor{
  float mass;
  float change_x;
  float change_y;

  public DynamicActor(float scale, float x, float y, float w, float h, int rgb, float objectMass, float stokeThickness){
    super(scale, x, y, w, h, rgb, strokeThickness);
    mass = objectMass;
  }

  public boolean update(ArrayList<Sprite> collisions, ArrayList<Actor> verticalBounds, int frame){
    center_x += change_x;
    center_y += change_y;
  }

  public void applyForce(float force){
      change_y += (mass * force) / frameRate; // Multiply the gravitational velocity of the object by the current frame then divide by the total framerate to get the velocity in seconds
  }
}