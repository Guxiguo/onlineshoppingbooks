<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books" %>
<%@ page import="org.pan.util.strFormat" %>
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<%
String mesg = "";
int Id=0;
if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
		mesg = "你您要查看的图书不存在！";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("bookid"));
		if (!book.getOnebook(Id)){
			mesg = "您要查看的图书不存在！";
		}
	} catch (Exception e){
		mesg = "您要查看的图书不存在！";
	}
}

%>

<html>
<head>
<title>兴兴购书网　查看图书资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
function check()
{
	if (document.form1.amount.value<1){
		alert("您的购买数量错误");
		document.form1.amount.focus();
		return false;
	}
	return true;
}


</script>
<link rel="stylesheet" href="books.css" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
.style1 {color: #FF0000}
.style2 {color: #009900}
.style3 {color: #0000FF}
.style11 {	color: #FF00CC;
	font-size: 16px;
}
-->
</style></head>

<body text="#000000" >
<div align="center">
  <p class="style1">兴兴购书网欢迎您选购图书！</p>
  <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		books bk = (books) book.getBooklist().elementAt(0);			  
	%>
  <table width="90%" border="0" cellspacing="2" cellpadding="1">
      <tr> 
        <td align="right" width="120"><span class="style2">图书名称：</span></td>
        <td><%= bk.getBookName() %></td>
      </tr>
      <tr> 
        <td align="right" width="120"><span class="style2">作者：</span></td>
        <td><%= bk.getAuthor() %></td>
      </tr>
      <tr> 
        <td align="right" width="120"><span class="style2">所属类别：</span></td>
        <td><%= bk.getClassname() %></td>
      </tr>
      <tr> 
        <td align="right" width="120"><span class="style2">出版社：</span></td>
        <td><%= bk.getPublish() %></td>
      </tr>
      <tr> 
        <td align="right" width="120"><span class="style2">书号：</span></td>
        <td><%= bk.getBookNo() %></td>
      </tr>
      <tr> 
        <td align="right" width="120"><span class="style2">书价：</span></td>
        <td><%= bk.getPrince() %></td>
      </tr>
      <tr> 
        <td align="right" width="120" valign="top"><span class="style2">内容介绍：</span></td>
        <td><%= strFormat.toHtml(bk.getContent()) %></td>
      </tr>
      <tr> 
        <td align="right" width="120" valign="top"><span class="style2">总数量</span></td>
        <td><%= bk.getAmount() %></td>
      </tr> 
	  <tr> 
        <td align="right" width="120" valign="top"><span class="style2">剩余数量</span></td>
        <td><%= bk.getLeav_number() %></td>
      </tr> 
	  <tr> 
        <td align="right" width="120" valign="top"><span class="style2">登录时间</span></td>
        <td><%= bk.getRegTime() %></td>
      </tr>
      
  </table>
<% } %>
  <br><p><a href="javascript:window.close()">关闭窗口</a></p>
</div>
</body>
</html>
