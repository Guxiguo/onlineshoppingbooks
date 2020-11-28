<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="org.pan.web.book.shopuser" %>
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />
<%
long userid=0;
String mesg = "";

if (request.getParameter("userid")!=null && !request.getParameter("userid").equals("")) {
	try {
		userid = Long.parseLong(request.getParameter("userid"));
		if (!user.getUserinfo(userid)) {
			mesg = "要查询的用户信息不存在";
		}
	} catch(Exception e) {
		mesg = "该用户号不存在!";
	}
}

if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try{
		long id = Long.parseLong(request.getParameter("userid"));
		if (user.delete(id)) {
			mesg = "删除操作成功";
		} else {
			mesg = "删除操作出错";
		}
	} catch (Exception e) {
		mesg = "你要删除的用户号错误";
	}
}

%>

<html>
<head>
<title>兴兴购书网管理系统--查看用户详细资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="books.css" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
.style1 {color: #339900}
.style2 {color: #FF0000}
.style3 {
	color: #FF0099;
	font-size: 16px;
}
.style4 {color: #0000FF}
-->
</style></head>

<body text="#000000" onLoad="javascript:window.focus();">
<div align="center">

        <p class="style2">&nbsp;</p>
        <p class="style3">查看用户详细信息</p>
		<% if (!mesg.equals("")){
			out.println("<font color=red>"+ mesg +"</font><br><br>"); 
		} else {
			shopuser userinfo = (shopuser)user.getUserlist().elementAt(0);
		%>
	<table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#FFCC66">
	  <tr><td align=right width=100><span class="style1">用户名</span></td>
	  <td><%= userinfo.getUserName() %></td></tr> 
	  <tr><td align=right width=100><span class="style1">用户真名</span></td>
	  <td><%= userinfo.getNames() %></td></tr> 
	  <tr><td align=right width=100><span class="style1">性别</span></td>
	  <td><%= userinfo.getSex() %></td></tr> 
	  <tr><td align=right width=100><span class="style1">联系地址</span></td>
	  <td><%= userinfo.getAddress() %></td></tr> 
	  <tr><td align=right width=100><span class="style1">联系电话</span></td>
	  <td><%= userinfo.getPhone() %></td></tr> 
	  <tr><td align=right width=100><span class="style1">邮编</span></td>
	  <td><%= userinfo.getPost() %></td></tr> 
	  <tr><td align=right width=100><span class="style1">电子邮件</span></td>
	  <td><%= userinfo.getEmail() %></td></tr> 
	  <tr><td align=right width=100><span class="style1">注册来源</span></td>
	  <td><%= userinfo.getRegIpAddress() %></td></tr> 
	  <tr><td align=right width=100><span class="style1">注册时间</span></td>
	  <td><%= userinfo.getRegTime() %></td></tr>
  </table>
  <br>
  <a href="modiuser.jsp?userid=<%= userinfo.getId()%>">修改</a>&nbsp;&nbsp;
  <a href="showuser.jsp?action=del&userid=<%=userinfo.getId() %>" onClick="return(confirm('你真的要删除这个用户?'))">删除</a><br><br>
<%}%>
  <br><p><a href="javascript:window.close()">关闭窗口</a></p>
</div>
</body>
</html>
