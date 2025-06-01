long g_min_id = 114449330088992229L;

void setup()
{
  // X→ Y↓
  size(4096, 4096, P2D);
  background(255);
}

void draw()
{
  try
  {
    // トゥートを取得
    JSONArray json = getToots(g_min_id);
    if (json.size() == 0)
    {
      saveFrame("frames/######.png");
      exit();
    }
    
    // 画像が添付されているものをピックアップし、画面に画像を表示する
    for (int i = 0; i < json.size(); ++i)
    {
      JSONObject item = json.getJSONObject(i);
      
      if (i == 0)
      {
        String created_at = item.getString("created_at");
        println(created_at);
      }
      
      int fav = item.getInt("favourites_count");
      JSONArray media = item.getJSONArray("media_attachments");
      for (int j = 0; j < media.size(); ++j)
      {
        JSONObject mediaItem = media.getJSONObject(j);
        String url = mediaItem.getString("preview_url");
        
        // 画面に画像を表示する
        drawImage(url, fav);
      }
    }
    
    // g_min_idを更新する
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
    
    if (frameCount % 600 == 0)
    {
      saveFrame("frames/######.png");
    }
  }
  catch (Exception e)
  {
    saveFrame("frames/######.png");
    exit();
  }
}
