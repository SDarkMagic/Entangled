public class Map{
    ArrayList<Actor> mainObjects = new ArrayList<Actor>();
    ArrayList<DynamicActor> mainDynamicObjects = new ArrayList<DynamicActor>();
    ArrayList<Actor> subObjects = new ArrayList<Actor>();
    ArrayList<DynamicActor> subDynamicObjects = new ArrayList<DynamicActor>();
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
      description = json.getString("description");
      backgroundColor = json.getInt("background");
      spawn = getPosition(json.getJSONObject("spawn"));
      spawn2 = getPosition(json.getJSONObject("spawn2"));
      type = json.getString("type");
      movementEnabled = json.getBoolean("movement_enabled");
      boundaries.add(new Actor(1.0, width/2, height/2, width, 3));
      boundaries.add(new Actor(1.0, width/2, height - 2, width, 3));
      loadMapData(json.getJSONArray("objects_main"), mainObjects, mainDynamicObjects);
      loadMapData(json.getJSONArray("objects_sub"), subObjects, subDynamicObjects);
    }

    public void loadMapData(JSONArray data, ArrayList<Actor> staticStore, ArrayList<DynamicActor> dynamicStore){
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
            dynamicStore.add(new DynamicActor(name, scale, position.get("x"), position.get("y"), entity.getFloat("mass")));
          }
          else {
            staticStore.add(new Actor(name, scale, position.get("x"), position.get("y")));
          }
        }
        else {
          name = entity.getString("name");
          thickness = entity.getFloat("thickness");
          rgb = entity.getInt("color");
          if (dynamic){
            dynamicStore.add(new DynamicActor(name, scale, position.get("x"), position.get("y"), entity.getFloat("width") * 100, entity.getFloat("height") * 100, rgb, entity.getFloat("mass"), thickness));
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
      for (Actor object: this.mainObjects){
        object.display();
      }
      for (Actor object: this.subObjects){
        object.display();
      }
    }
}