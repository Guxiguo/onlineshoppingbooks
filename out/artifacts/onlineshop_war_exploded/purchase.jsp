<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books" %>
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<jsp:useBean id="shop" scope="page" class="org.pan.web.purchase" />

<%
String mesg = "";
String submits = request.getParameter("Submit");
int Id=0;
if (submits!=null && !submits.equals("")){
	if (shop.addnew(request)){
		mesg = "图书已经放入您的购物车中，谢谢！";
	} else if (shop.getIsEmpty()){
		mesg = "库存图书数量不足！只剩"+shop.getLeaveBook()+"本";
	} else {
		mesg = "暂时不能购买！";
	}
}else {
	if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
			mesg = "您要购买的图书不存在！";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("bookid"));
			if (!book.getOnebook(Id)){
				mesg = "您要购买的图书不存在！";
			}
		} catch (Exception e){
			mesg = "您要购买的图书不存在！";
		}
	}
}
%>
<html>
<head>
<title>兴兴购书网　购买图书</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

function check()
{
	if (document.form1.amount.value<1){
		alert("您的购买数量错误！");
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
.style2 {color: #336633}
.style6 {color: #FF0000}
-->
</style></head>

<body text="#000000" onLoad="javascript:window.focus();">
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
        <td align="center"><span class="style2">图书名称：<%= bk.getBookName() %></span></td>
      </tr>
      <tr align="center"> 
        <td><span class="style2">您要购买的数量： 
            <input type="text" name="amount" maxlength="4" size="3" value="1"> 
          本</span></td>
      </tr>
      <tr align="center"> 
        <td>
		  <input type="hidden" name="bookid" value="<%=Id %>">
          <input type="submit" name="Submit" value="购 买" onClick="return(check());">
          <input type="reset" name="Reset" value="取 消">
        </td>
      </tr>
	   <tr align="center"> 
        <td><a href="#" onClick="openScript('showbook.jsp?bookid=<%= Id %>','show',400,450)" >查看详细资料</a> </td>
      </tr>
   </form>
  </table>
<% } %>
  <br>
  <p><a href="javascript:window.close()">关闭窗口</a></p>
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center"><span class="style6">兴兴购书网欢迎您的光临！</span><br>      </td>
    </tr>
  </table>
</div>
</body>
</html>
