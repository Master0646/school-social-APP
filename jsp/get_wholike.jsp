<%@page contentType="text/html; charset=UTF-8" language="java"
	import="java.text.*,org.json.JSONObject,java.util.ArrayList,java.io.PrintWriter"
	import="java.util.HashMap,java.util.List,java.sql.*,java.util.Map,java.io.IOException"
	import="java.util.Date,java.util.Calendar"%>
<%
	JSONObject jsonlist;
	String file_id=request.getParameter("file_id");
	String user_id=request.getParameter("user_id");
	
	
	ArrayList<JSONObject> goods_list=new ArrayList<JSONObject>();
	try {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_social?user=root&password=root&useUnicode=true&characterEncoding=UTF-8");
		Statement statement = conn.createStatement();
		String sql="select * from file_dianzan  where file_id = '"+file_id+"' and user_id='"+user_id+"'";
		ResultSet rs = statement.executeQuery(sql);
		while (rs.next()) {
			jsonlist=new JSONObject();
			jsonlist.put("date",rs.getString("date"));
	
			goods_list.add(jsonlist);
		}
		statement.close();
		conn.close();
		System.out.println("close");
	} catch (SQLException sqlexception) {
		sqlexception.printStackTrace();
	}
	out.println("1111");
	JSONObject jsonObj=new JSONObject();
	jsonObj.put("Data",goods_list);
	jsonObj.put("result_msg","ok");	
	jsonObj.put("result_code",0);
	response.setContentType("text/html; charset=UTF-8");
	try {
		response.getWriter().print(jsonObj);
		response.getWriter().flush();
		response.getWriter().close();
	} catch (IOException e) {
			e.printStackTrace();
	}
%>