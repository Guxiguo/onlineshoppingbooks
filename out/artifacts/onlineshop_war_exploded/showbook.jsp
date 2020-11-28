<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books" %>
<%@ page import="org.pan.util.strFormat" %>
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<%
String mesg = "";
int Id=0;
if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
		mesg = "你要查看的图书不存在！";
} else {
	try {
		Id = Integer.parseInt(request.getParameter("bookid"));
		if (!book.getOnebook(Id)){
			mesg = "你要查看的图书不存在！";
		}
	} catch (Exception e){
		mesg = "你要查看的图书不存在！";
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
		alert("你的购买数量有问题");
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
.style1 {
	color: #FF0099;
	font-size: 16px;
}
.style2 {color: #009900}
.style6 {color: #FF0000}
.style11 {color: #FF0000}
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
    <form name="form1" method="post" action="purchase.jsp">
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
        <td align="right" width="120" valign="top"><span class="style2"></span></td>
        <td>&nbsp;</td>
      </tr>
      <tr> 
        <td align="right" width="120" valign="top"><span class="style2">购买：</span></td>
        <td> 
          <input type="text" name="amount" maxlength="5" size="3" value="1">
          <span class="style2">本</span></td>
      </tr>
      <tr> 
        <td align="right" width="120" valign="top">&nbsp;</td>
        <td> 
		  <input type="hidden" name="bookid" value="<%=Id %>" >
          <input type="submit" name="Submit" value="购买" onClick="return(check());">
          <input type="reset" name="reset" value="取消">
        </td>
      </tr>
   </form>
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
