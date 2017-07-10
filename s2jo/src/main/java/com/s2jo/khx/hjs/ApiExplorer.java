package com.s2jo.khx.hjs;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;


import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Repository;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.IOException;

//===== Api Explorer 클래스 생성하기 =====

@Repository
public class ApiExplorer {
	
	
	// 시/도, 군/구 별 관광지 목록 불러오는 메소드
    public ArrayList<HashMap<String, String>> tourList(String P_SIDO, String P_GUNGU) throws Exception{
    	
        StringBuilder urlBuilder = new StringBuilder("http://openapi.tour.go.kr/openapi/service/TourismResourceService/getTourResourceList"); /*URL*/
        
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=eFlzqtWy00byos9tnPd%2FjvF1fg5k6AyKlUUBABdHaLMt3QVJWkNBg6le1g8THhaQxMfZ%2BQb6pDSyfxM7ixeqZg%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("SIDO","UTF-8") + "=" + URLEncoder.encode(P_SIDO, "UTF-8")); /*시도*/
        urlBuilder.append("&" + URLEncoder.encode("GUNGU","UTF-8") + "=" + URLEncoder.encode(P_GUNGU, "UTF-8")); /*시군구 ==> 안넣으면 시 전체에서 관광지 뽑아옴.*/
        urlBuilder.append("&" + URLEncoder.encode("RES_NM","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*관광지*/ 
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*json 타입*/ 
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();		// url 연결
        
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        
 //       System.out.println("Response code: " + conn.getResponseCode());	// 200
        
        BufferedReader rd;
        
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
       } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        
        rd.close();
        conn.disconnect();
        
        JSONObject jsonObj = new JSONObject(sb.toString());
        
        JSONObject json =  (JSONObject) jsonObj.get("response");
        JSONObject json2 =  (JSONObject) json.get("body");
        JSONObject json3 =  (JSONObject) json2.get("items");
        JSONArray array = (JSONArray)json3.get("item");
        
        ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
       
        for(int i = 0 ; i < array.length(); i++){           
            JSONObject entity = (JSONObject)array.get(i);
            
            String SctnNm = (String) entity.get("ASctnNm");
            String RES_NM = (String) entity.get("BResNm");
            String SIDO = (String) entity.get("CSido");
            String GUNGU = (String) entity.get("DGungu");
            /*
            String PreSimpleDesc = "-";
            if(!entity.isNull("EPreSimpleDesc")){
            	PreSimpleDesc = (String) entity.get("EPreSimpleDesc");
            }
			*/
            HashMap<String, String> map = new HashMap<String, String>();
            
            map.put("SctnNm", SctnNm);
            map.put("RES_NM", RES_NM);
            map.put("SIDO", SIDO);
            map.put("GUNGU", GUNGU);
            
         //   map.put("PreSimpleDesc", PreSimpleDesc);
            
            list.add(map); 
        }
        
        return list;     
    }
    

    
    
	
	// 시/도, 군/구, 관광지 이름으로 관광지 목록에서 관광지 개요만 불러오는 메소드
    public String tourDesc(String P_SIDO, String P_GUNGU, String P_RES_NM) throws Exception{
    	
        StringBuilder urlBuilder = new StringBuilder("http://openapi.tour.go.kr/openapi/service/TourismResourceService/getTourResourceList"); /*URL*/
        
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=eFlzqtWy00byos9tnPd%2FjvF1fg5k6AyKlUUBABdHaLMt3QVJWkNBg6le1g8THhaQxMfZ%2BQb6pDSyfxM7ixeqZg%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("SIDO","UTF-8") + "=" + URLEncoder.encode(P_SIDO, "UTF-8")); /*시도*/
        urlBuilder.append("&" + URLEncoder.encode("GUNGU","UTF-8") + "=" + URLEncoder.encode(P_GUNGU, "UTF-8")); /*시군구 ==> 안넣으면 시 전체에서 관광지 뽑아옴.*/
        urlBuilder.append("&" + URLEncoder.encode("RES_NM","UTF-8") + "=" + URLEncoder.encode(P_RES_NM, "UTF-8")); /*관광지*/ 
        urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*json 타입*/ 
        
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();		// url 연결
        
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        
 //       System.out.println("Response code: " + conn.getResponseCode());	// 200
        
        BufferedReader rd;
        
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
       } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        
        rd.close();
        conn.disconnect();
        
        JSONObject jsonObj = new JSONObject(sb.toString());
        
        JSONObject json =  (JSONObject) jsonObj.get("response");
        JSONObject json2 =  (JSONObject) json.get("body");
        JSONObject json3 =  (JSONObject) json2.get("items");
        String PreSimpleDesc = "-";
        
        if (json3.get("item") instanceof JSONObject){
        	JSONObject entity =  (JSONObject) json3.get("item");
        	
             if(!entity.isNull("EPreSimpleDesc")){
             	PreSimpleDesc = (String) entity.get("EPreSimpleDesc");
             }
        	
        }
        
        if (json3.get("item")  instanceof JSONArray){
        	JSONArray array = (JSONArray)json3.get("item");
        	
        	for(int i = 0 ; i < 1; i++){           
            
            JSONObject entity = (JSONObject)array.get(i);
            if(!entity.isNull("EPreSimpleDesc")){
        		PreSimpleDesc = (String) entity.get("EPreSimpleDesc");
        	}
        	
        	}
        }
    
        return PreSimpleDesc;     
    }
    
    
    
   // 관광지 상세정보 불러오는 메소드
    public HashMap<String, String>  tourDetail(String P_SIDO, String P_GUNGU, String P_RES_NM) throws Exception{
    	
    	 StringBuilder urlBuilder = new StringBuilder("http://openapi.tour.go.kr/openapi/service/TourismResourceService/getTourResourceDetail"); /*URL*/
    	 
         urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=eFlzqtWy00byos9tnPd%2FjvF1fg5k6AyKlUUBABdHaLMt3QVJWkNBg6le1g8THhaQxMfZ%2BQb6pDSyfxM7ixeqZg%3D%3D"); /*Service Key*/
         urlBuilder.append("&" + URLEncoder.encode("SIDO","UTF-8") + "=" + URLEncoder.encode(P_SIDO, "UTF-8")); /*시도*/
         urlBuilder.append("&" + URLEncoder.encode("GUNGU","UTF-8") + "=" + URLEncoder.encode(P_GUNGU, "UTF-8")); /*시군구*/
         urlBuilder.append("&" + URLEncoder.encode("RES_NM","UTF-8") + "=" + URLEncoder.encode(P_RES_NM, "UTF-8")); /*관광지*/
         urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*json 타입*/ 
         
         URL url = new URL(urlBuilder.toString());
         HttpURLConnection conn = (HttpURLConnection) url.openConnection();
         
         conn.setRequestMethod("GET");
         conn.setRequestProperty("Content-type", "application/json");
         
  //       System.out.println("Response code: " + conn.getResponseCode());
         
         BufferedReader rd;
         
         if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
             rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
         } else {
             rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
         }
         
         StringBuilder sb = new StringBuilder();
         String line;
         
         while ((line = rd.readLine()) != null) {
             sb.append(line);
         }
         
         rd.close();
         conn.disconnect();

         JSONObject jsonObj = new JSONObject(sb.toString());
        
         JSONObject json =  (JSONObject) jsonObj.get("response");
         JSONObject json2 =  (JSONObject) json.get("body");
         JSONObject entity =  (JSONObject) json2.get("item");
         
        
         HashMap<String, String> map = new HashMap<String, String>();
         
         
         String ASctnNm = (String) entity.get("ASctnNm");
         String BResNm = (String) entity.get("BResNm");
         String CSido = (String) entity.get("CSido");
         String DGungu = (String) entity.get("DGungu");
        
         String HEnglishNm = "--";
         if(!entity.isNull("HEnglishNm")){
        	 HEnglishNm = (String) entity.get("HEnglishNm");
         }
        
         String KPhone = "--";
         if(!entity.isNull("KPhone")){
        	 KPhone = (String) entity.get("KPhone");
         }
         
         
         if(!entity.isNull("LGpsCoordinate")){
        	 String LGpsCoordinate = (String) entity.get("LGpsCoordinate");
         
         // x,y좌표 분리하고 형태변환하기  :  37˚31˙44.13, 126˚59˙35.82  ====> 37.314413,  126.593582 
         // ==== 1. x좌표, y좌표 분리하기
         
         int a1 = LGpsCoordinate.indexOf(','); // 콤마 위치 알아오기
         
  //       System.out.println("콤마 위치 ==>" + a1); // 11
         
		 String x1 = LGpsCoordinate.substring(a1 + 1) ;  // a1 + 1
		 String y1 = LGpsCoordinate.substring(0, a1); // 0 , a1
		
		 // ==== 2. x좌표, y좌표 각각 형태 변환하기
		 
		 String x2=x1.replace(".", "");
		 String y2=y1.replace(".", "");
		 
		 String x3=x2.replace("˚", ".");
		 String y3=y2.replace("˚", ".");
		 
		 String x=x3.replace("˙", ""); // 최종 좌표
		 String y=y3.replace("˙", "");
        
         map.put("x", x);
         map.put("y", y);
         
         }
         
         String Desc = tourDesc(CSido, DGungu, BResNm);  // 개요 불러오는 메소드 

         map.put("ASctnNm", ASctnNm);
         map.put("BResNm", BResNm);
         map.put("CSido", CSido);
         map.put("DGungu", DGungu);
         map.put("HEnglishNm", HEnglishNm);
         map.put("KPhone", KPhone);

         map.put("Desc", Desc);

         return map;        

    }
    
}// end of class ------