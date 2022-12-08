public class Map{
    ArrayList<Sprite> objects = new ArrayList<Sprite>();
    ArrayList<DynamicSprite> dynamicObjects = new ArrayList<DynamicSprite>();
    JSONArray data;
    FloatDict spawn;
    String type;
    int backgroundColor;

    public Map(String mapFilePath){
      JSONObject json = loadJSONObject(mapFilePath);
      backgroundColor = json.getInt("background");
      spawn = getPosition(json.getJSONObject("spawn"));
      type = json.getString("type");
      data = json.getJSONArray("objects");
      for (int i = 0; i < data.size(); i++){
        JSONObject entity = data.getJSONObject(i);
        FloatDict position = getPosition(entity.getJSONObject("translate"));
        boolean dynamic = entity.getBoolean("is_dynamic");
        String name = entity.getString("name");
        float scale = entity.getFloat("scale");
        if (dynamic){
          dynamicObjects.add(new DynamicSprite(name, scale, position.get("x"), position.get("y"), entity.getFloat("mass")));
        }
        else {
          objects.add(new Sprite(name, scale, position.get("x"), position.get("y")));
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