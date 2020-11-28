<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
String username = (String)session.getAttribute("username");
if ( username == null || username.equals("") ){
	response.sendRedirect("login.jsp?msg=nologin");
}
%>
<%@ page import="org.pan.web.book.books" %>
<%@ page import="org.pan.web.book.indentlist" %>
<jsp:useBean id="myIndentlist" scope="page" class="org.pan.web.purchase" />
<jsp:useBean id="mybook" scope="page" class="org.pan.web.booksmn" />
<%
String mesg = "";
long Id=0;
String indentNo = request.getParameter("orderno");
if (indentNo==null) indentNo="";
if (request.getParameter("id")==null || request.getParameter("id").equals("")) {
		mesg = "你要查看的订单清单不存在！";
} else {
	try {
		Id = Long.parseLong(request.getParameter("id"));
		if (!myIndentlist.getIndentList(Id)){
			mesg = "你要查看的订单清单不存在！";
		}
	} catch (Exception e){
		mesg = "你要查看的订单清单不存在！";
	}
}

%>

<html>
<head>
<title>兴兴购书网　查看订购清单资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<link rel="stylesheet" href="books.css" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
.style1 {
	color: #CC6600;
	font-size: 16px;
}
.style2 {color: #009966}
.style6 {color: #FF0000}
.style11 {color: #FF0000}
-->
</style></head>

<body text="#000000" onLoad="javascript:window.focus();" >
<div align="center">
  
  <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
	%>
		<p class="style1">兴兴购书网图书订单<%= indentNo %>&nbsp;清单:</p>
<table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#CC9966">
          <tr align="center"> 
            <td><span class="style2">图书名称</span></td>
            <td><span class="style2">作者</span></td>
            <td><span class="style2">图书类别</span></td>
            <td><span class="style2">单价(元)</span></td>
            <td><span class="style2">数量</span></td>
          </tr>
	<%
	for (int i=0; i<myIndentlist.getIndent_list().size();i++){
		indentlist idList = (indentlist) myIndentlist.getIndent_list().elementAt(i);
		if (mybook.getOnebook((int)idList.getBookNo()) ){
			books bk = (books) mybook.getBooklist().elementAt(0);		
	%>	  
	      <tr align="center"> 
            <td><%= bk.getBookName() %></td>
            <td><%= bk.getAuthor() %></td>
            <td><%= bk.getClassname() %></td>
            <td><%= bk.getPrince() %></td>
            <td><%= idList.getAmount() %></td>
          </tr>
	<%
		}
	}%>
		</table>
<% } %>
  <br><p><a href="javascript:window.close()">关闭窗口</a></p>
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center"><span class="style6"><span class="style11">兴兴购书网</span>欢迎您的光临！</span><br>      </td>
    </tr>
  </table>
  
</div>
</body>
</html>
<%mybook.close();%>