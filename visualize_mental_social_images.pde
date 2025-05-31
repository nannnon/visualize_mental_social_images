long g_min_id = 1L;

void setup()
{
  // X→ Y↓
  size(1024, 1024, P2D);
  background(255);
}

void draw()
{
  // トゥートを取得
  JSONArray json = getToots(g_min_id);
  if (json.size() == 0)
  {
    exit();
  }
  
  // 画像が添付されているものをピックアップする
  ArrayList<ImageAndFav> pickedUpItems = new ArrayList<ImageAndFav>();
  for (int i = 0; i < json.size(); ++i)
  {
    JSONObject item = json.getJSONObject(i);
    int fav = item.getInt("favourites_count");
    JSONArray media = item.getJSONArray("media_attachments");
    
    for (int j = 0; j < media.size(); ++j)
    {
      JSONObject mediaItem = media.getJSONObject(j);
      String url = mediaItem.getString("preview_url");
      pickedUpItems.add(new ImageAndFav(url, fav));
    }
  }
  
  // 画面に画像を表示する
  for (ImageAndFav imgFav : pickedUpItems)
  {
    PImage img = loadImage(imgFav.imageURL);
    int fav = imgFav.favouritesCount;
    
    image(img, 0, 0);
  }
  
  // min_idを更新する
  long biggestID = 0;
  for (int i = 0; i < json.size(); ++i)
  {
    JSONObject item = json.getJSONObject(i);
    long id = item.getLong("id");
    if (id > biggestID)
    {
      biggestID = id;
    }
  }
  g_min_id = biggestID + 1L;

  println("g_min_id: " + g_min_id); //<>//
}
