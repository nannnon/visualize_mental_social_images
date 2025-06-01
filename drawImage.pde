class PosSize
{
  float x;
  float y;
  float w;
  float h;
}

ArrayList<PosSize> g_posSizes = new ArrayList<PosSize>();

boolean isHit(PosSize target)
{
  for (PosSize ps: g_posSizes)
  {
    if (target.x + target.w >= ps.x &&
        target.x            <= ps.x + ps.w &&
        target.y + target.h >= ps.y &&
        target.y            <= ps.y + ps.h)
    {
      return true;
    }
  }
  
  return false;
}

void drawImage(String url, int fav)
{
  try
  {
    //if (fav < 10)
    //{
    //  return;
    //}
    
    PImage img = loadImage(url);
    float scaleFactor = min((fav + 1.0) / 16.0, 1);
    
    PosSize posSize = new PosSize();
    posSize.w = scaleFactor * img.width;
    posSize.h = scaleFactor * img.height;
    
    int counter = 0;
    while (counter < 1024)
    {
      posSize.x = random(0, width - posSize.w);
      posSize.y = random(0, height - posSize.h);
      
      if (!isHit(posSize))
      {
        image(img, posSize.x, posSize.y, posSize.w, posSize.h);
        g_posSizes.add(posSize);
        break;
      }
      
      ++counter;
    }
    if (counter >= 1024)
    {
      println("counter >= 1024");
      saveFrame("frames/######.png");
      exit();
    }
  }
  catch (Exception e)
  {
    return;
  }
}
