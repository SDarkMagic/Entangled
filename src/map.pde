public class Map{
    ArrayList<Actor> mainObjects = new ArrayList<Actor>();
    ArrayList<Actor> mainDynamicObjects = new ArrayList<Actor>();
    ArrayList<Actor> subObjects = new ArrayList<Actor>();
    ArrayList<Actor> subDynamicObjects = new ArrayList<Actor>();
    ArrayList<Actor> boundaries = new ArrayList<Actor>();
    JSONArray data;
    FloatDict spawn;
    FloatDict spawn2;
    String type;
    int backgroundColor;
    boolean movementEnabled;
    String description;

    public Map(String mapFilePath){
      JSONObject json = loadJSONObject(mapFilePath);
      description = json.getString("description"); // Text displayed at the top of the screen that explains the base mechanics or story for a level
      backgroundColor = json.getInt("background");
      // The two locations where the player characters will be created
      spawn = getPosition(json.getJSONObject("spawn"));
      spawn2 = getPosition(json.getJSONObject("spawn2"));
      type = json.getString("type"); // The level type. Determines control scheme used and various logic required when running the game
      movementEnabled = json.getBoolean("movement_enabled"); // Controls whether or not the controls allow for movement of the player character
      boundaries.add(new Actor(1.0, width/2, height/2, width, 3));
      boundaries.add(new Actor(1.0, width/2, height - 2, width, 3));
      loadMapData(json.getJSONArray("objects_main"), mainObjects, mainDynamicObjects);
      loadMapData(json.getJSONArray("objects_sub"), subObjects, subDynamicObjects);
    }

    public void loadMapData(JSONArray data, ArrayList<Actor> staticStore, ArrayList<Actor> dynamicStore){
      // Load required data for all entities in a json map file.
      for (int i = 0; i < data.size(); i++){
        String name;
        float thickness;
        int rgb;
        JSONObject entity = data.getJSONObject(i);
        FloatDict position = getPosition(entity.getJSONObject("translate"));
        boolean dynamic = entity.getBoolean("is_dynamic");
        float scale = entity.getFloat("scale");

        if (entity.getBoolean("use_sprite")){
          name = entity.getString("name") + ".png";
          if (dynamic){
            dynamicStore.add(new Actor(name, scale, position.get("x"), position.get("y")));
          }
          else {
            staticStore.add(new Actor(name, scale, position.get("x"), position.get("y")));
          }
        }
        else {
          name = entity.getString("name");
          thickness = entity.getFloat("thickness");
          rgb = entity.getInt("color");
          // If an actor is dynamic, it will have a constant velocity so we need to get that information.
          if (dynamic){
            float speed = entity.getFloat("speed");
            boolean isVerticalMotion = entity.getBoolean("motionIsVertical");
            Actor actor = new Actor(name, scale, position.get("x"), position.get("y"), entity.getFloat("width") * 100, entity.getFloat("height") * 100, rgb, thickness);
            if (isVerticalMotion){
              actor.change_y = speed;
            }
            else {
              actor.change_x = speed;
            }
            dynamicStore.add(actor);
          }
          else {
            staticStore.add(new Actor(name, scale, position.get("x"), position.get("y"), entity.getFloat("width") * 100, entity.getFloat("height") * 100, rgb, thickness));
          }
        }
      }
    }

    // Get the x & y coordinates from the map data for a given json object and format them into a float dict for easier access
    private FloatDict getPosition(JSONObject translate){
      FloatDict position = new FloatDict();
      position.set("x", translate.getFloat("X") * 100);
      position.set("y", translate.getFloat("Y") * 100);
      return position;
    }

    public void display(PostLevelMenu postLevel){
      postLevel.hideMenu();
      textSize(32);
      background(this.backgroundColor);
      // Draw the screen divider
      strokeWeight(3);
      for (Actor boundary: this.boundaries){
        line(0, boundary.center_y, boundary.w, boundary.center_y);
      }
      for (Actor object: this.mainDynamicObjects){
        object.center_x += object.change_x;
        object.center_y += object.change_y;
        object.display();
      }
      for (Actor object: this.subDynamicObjects){
        object.center_x += object.change_x;
        object.center_y += object.change_y;
        object.display();
      }
      for (Actor object: this.mainObjects){
        object.display();
      }
      for (Actor object: this.subObjects){
        object.display();
      }
    }
}