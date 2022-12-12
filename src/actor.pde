//static float GRAVITY = 9.8;

// Abstract class for handling entities to make collision processing easier
public class Actor{
  float center_x, center_y;
  float w, h;
  PImage sprite;
  float change_x;
  float change_y;
  int baseColor;
  float thickness;
  String name;

  public Actor(String actorName, float scale, float x, float y, float sizeX, float sizeY, int rgb, float strokeThickness){
    center_x = x;
    center_y = y;
    change_x = 0;
    change_y = 0;
    w = sizeX * scale;
    h = sizeY * scale;
    baseColor = rgb;
    thickness = strokeThickness;
    sprite = null;
    name = actorName;
  }

  public Actor(float scale, float x, float y, float sizeX, float sizeY, int rgb, float strokeThickness){
    this("", scale, x, y, sizeX, sizeY, rgb, strokeThickness);
  }

  public Actor(float scale, float x, float y, float sizeX, float sizeY, int rgb){
    this("", scale, x, y, sizeX, sizeY, rgb, 3);
  }

  public Actor(float scale, float x, float y, float sizeX, float sizeY){
    this(scale, x, y, sizeX, sizeY, 0);
  }

  public Actor(float scale, float x, float y){
    this(scale, x, y, 0, 0, 0);
  }

  public Actor(String fileName, float scale, float x, float y){
    sprite = loadImage(fileName);
    center_x = x;
    center_y = y;
    change_x = 0;
    change_y = 0;
    w = sprite.width * scale;
    h = sprite.height * scale;
    baseColor = 0;
    thickness = 0;
    name = fileName;
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
    if (sprite != null){
        image(sprite, center_x, center_y, w, h);
    }
    else{
        strokeWeight(thickness);
        line(center_x - w/2, center_y - h/2, center_x + w/2, center_y + h/2);
    }
  }
}

// Simple extension of the actor class that is capable of being repositioned each frame and detecting collision
public class DynamicActor extends Actor{
  float mass;
  float change_x;
  float change_y;

  public DynamicActor(String name, float scale, float x, float y, float w, float h, int rgb, float objectMass, float strokeThickness){
    super(name, scale, x, y, w, h, rgb, strokeThickness);
    mass = objectMass;
  }

  public DynamicActor(float scale, float x, float y, float w, float h, int rgb, float objectMass, float strokeThickness){
    super(scale, x, y, w, h, rgb, strokeThickness);
    mass = objectMass;
  }

  public DynamicActor(String fileName, float scale, float x, float y, float objectMass){
    super(fileName, scale, x, y);
    mass = objectMass;
  }

  public DynamicActor(String fileName, float scale, float x, float y){
    super(fileName, scale, x, y);
    mass = 0;
  }

  public int update(ArrayList<Actor> collisions, ArrayList<Actor> verticalBounds, int frame){
    int colliding = ensureInBounds(this, verticalBounds); //Value of 0 is no collision between actors
    if(collisions.size() > 0){
      for (Actor object: collisions){
        if (object.name.equals("goal")){
            colliding = 2; // Value of 2 means the player is colliding with a goal actor
        }
        else {
          resolveCollision(this, object);
        }
      }
      colliding = 1;
    }
    else {
      center_x += change_x;
      center_y += change_y;
    }
    return colliding;
  }

  public void applyForce(float force){
      change_y += (mass * force) / frameRate; // Multiply the gravitational velocity of the object by the current frame then divide by the total framerate to get the velocity in seconds
  }
}
