public class Map{
    ArrayList<Sprite> mainObjects = new ArrayList<Sprite>();
    ArrayList<DynamicSprite> mainDynamicObjects = new ArrayList<DynamicSprite>();
    ArrayList<Sprite> subObjects = new ArrayList<Sprite>();
    ArrayList<DynamicSprite> subDynamicObjects = new ArrayList<DynamicSprite>();
    JSONArray data;
    FloatDict spawn;
    FloatDict spawn2;
    String type;
    int backgroundColor;
    boolean movementEnabled;

    public Map(String mapFilePath){
      JSONObject json = loadJSONObject(mapFilePath);
      backgroundColor = json.getInt("background");
      spawn = getPosition(json.getJSONObject("spawn"));
      spawn2 = getPosition(json.getJSONObject("spawn2"));
      type = json.getString("type");
      movementEnabled = json.getBoolean("movement_enabled");
      loadMapData(json.getJSONArray("objects_main"), mainObjects, mainDynamicObjects);
      loadMapData(json.getJSONArray("objects_sub"), subObjects, subDynamicObjects);
    }

    public void loadMapData(JSONArray data, ArrayList<Sprite> staticStore, ArrayList<DynamicSprite> dynamicStore){
      for (int i = 0; i < data.size(); i++){
        JSONObject entity = data.getJSONObject(i);
        FloatDict position = getPosition(entity.getJSONObject("translate"));
        boolean dynamic = entity.getBoolean("is_dynamic");
        String name = entity.getString("name");
        float scale = entity.getFloat("scale");
        if (dynamic){
          dynamicStore.add(new DynamicSprite(name, scale, position.get("x"), position.get("y"), entity.getFloat("mass")));
        }
        else {
          staticStore.add(new Sprite(name, scale, position.get("x"), position.get("y")));
        }
      }
    }

    // Get the x & y coordinates from the map data for a given json object and format them into a float dict for easier access
    public FloatDict getPosition(JSONObject translate){
      FloatDict position = new FloatDict();
      position.set("x", translate.getFloat("X") * 100);
      position.set("y", translate.getFloat("Y") * 100);
      return position;
    }
}