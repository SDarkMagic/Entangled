public class Map{
    ArrayList<Sprite> objects = new ArrayList<Sprite>();
    JSONArray data;

    public Map(String mapFilePath){
      JSONObject json = loadJSONObject(mapFilePath);
      data = json.getJSONArray("objects");
      for (int i = 0; i < data.size(); i++){
        JSONObject entity = data.getJSONObject(i);
        JSONObject position = entity.getJSONObject("translate");
        boolean dynamic = entity.getBoolean("is_dynamic");
        String name = entity.getString("name");
        float scale = entity.getFloat("scale");
        Sprite sprite = new Sprite(name, scale, position.getFloat("X") * 100, position.getFloat("Y") * 100);
        objects.add(sprite);
      }
    }
}