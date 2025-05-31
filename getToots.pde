import http.requests.*;

int g_previousTime = 0;

JSONArray getToots(long min_id)
{
  // mental.socialのローカルタイムラインから、指定min_id以降のトゥートを40件取得する
  String req = "https://mental.social/api/v1/timelines/public?local=true&limit=40&min_id=" + Long.toString(min_id);
  
  // mastodonのAPIを叩く回数を制限する
  int elapsedTime = millis() - g_previousTime;
  final int WaitMSecs = 2000;
  if (elapsedTime < WaitMSecs)
  {
    delay(WaitMSecs - elapsedTime);
  }

  // GET
  GetRequest get = new GetRequest(req);
  get.send();
  g_previousTime = millis();

  // Jsonにパース
  JSONArray json = parseJSONArray(get.getContent());  
  return json;
}
