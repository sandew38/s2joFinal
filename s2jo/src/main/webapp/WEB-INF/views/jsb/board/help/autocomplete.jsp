<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="http://code.jquery.com/ui/1.12.0-rc.2/themes/smoothness/jquery-ui.css" rel="Stylesheet"></link>
<script src="http://code.jquery.com/ui/1.12.0-rc.2/jquery-ui.js" ></script>

<script type="text/javascript">
request.setCharacterEncoding("UTF-8");
    String value = request.getParameter("value");
    JSONArray list = new JSONArray();
    JSONObject object = null;
     
    if(value.indexOf("개발") > -1) {
        object = new JSONObject();
        object.put("data", "개발자");
        list.add(object);
        object = new JSONObject();
        object.put("data", "개발로짜");
        list.add(object);
        object = new JSONObject();
        object.put("data", "개발이 어려워요");
        list.add(object);
        object = new JSONObject();
        object.put("data", "개발이란?");
        list.add(object);
    }else if(value.indexOf("블로") > -1) {
        object = new JSONObject();
        object.put("data", "블로그꾸미기");
        list.add(object);      
        object = new JSONObject();
        object.put("data", "블로그누락");
        list.add(object);
        object = new JSONObject();
        object.put("data", "개발로짜의블로그");
        list.add(object);
        object = new JSONObject();
        object.put("data", "블로장생");
        list.add(object);
    }
         
    PrintWriter pw = response.getWriter();
    pw.print(list);
    pw.flush();
    pw.close();
</script>