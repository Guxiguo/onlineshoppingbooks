<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>

<%@ page import="org.pan.web.book.*" %>
<%@ page import="org.pan.util.strFormat" %>
<jsp:useBean id="myIndentlist" scope="page" class="org.pan.web.purchase" />
<jsp:useBean id="mybook" scope="page" class="org.pan.web.booksmn" />
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />

<%
String mesg = "";
long Id=0;
String submit= request.getParameter("submit");
if (submit!=null && !submit.equals("")){
	if (myIndentlist.update(request))
		mesg = "更新订单状态成功！";
	else 
		mesg = "更新订单状态出错!";
}

if (request.getParameter("indentid")==null || request.getParameter("indentid").equals("")) {
		mesg = "您要查看的订单清单不存在！";
} else {
	try {
		Id = Long.parseLong(request.getParameter("indentid"));
		if (!myIndentlist.getOneIndent(Id) || !myIndentlist.getIndentList(Id)){
			mesg = "您要查看的订单清单不存在！";
		}
	} catch (Exception e){
		mesg = "您要查看的订单清单不存在！";
	}
}



%>

<html>
<head>
<title>兴兴购书网管理系统　查看订购清单资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

  function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
</script>

<link rel="stylesheet" href="books.css" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
.style1 {
	color: #FF00CC;
	font-size: 16px;
}
.style2 {color: #009900}
.style3 {color: #6633FF}
-->
</style></head>

<body text="#000000" onLoad="javascript:window.focus();" >
<div align="center">
  
  <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		indent Ident = (indent) myIndentlist.getMy_indent().elementAt(0);
	%>
		<p class="style1">兴兴购书网图书订单<%= Ident.getIndentNo() %>&nbsp;清单:</p>
          <table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#CC9966">
          <tr align="center"> 
            <td><span class="style2">图书名称</span></td>
            <td><span class="style2">作者</span></td>
            <td><span class="style2">图书类别</span></td>
            <td><span class="style2">单价(元)</span></td>
            <td><span class="style2">数量</span></td>
          </tr>
	<%
	float totalprice =0;
	int totalamount = 0;
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
	<%	totalprice = totalprice + bk.getPrince() * idList.getAmount();
		totalamount = totalamount + idList.getAmount();
		} %>
	
<%   }%><tr align="center"> 
            <td colspan=5 ><span class="style3">购买的总金额是：<%= totalprice %>元,总数量是<%= totalamount%>本</span></td> </tr>
		</table>
  <br>
  <table width="95%" border="1" cellspacing="2" cellpadding="1" bordercolor="#CC9966">
    <tr> 
      <td width="40%" align="right"><span class="style2">下单用户：</span></td>
      <td width="60%"><%
				if (user.getUserinfo(Ident.getUserId()) ) {
					shopuser userinfo = (shopuser)user.getUserlist().elementAt(0); %>
				<a href="#" onClick="openScript('showuser.jsp?userid=<%= Ident.getUserId() %>','showuser',450,500)"><%= userinfo.getUserName() %></a>
			<%} else {
					out.println("该用户已被删除");
				}			
			%></td>
    </tr>
    <tr> 
      <td width="40%" align="right"><span class="style2">下单时间：</span></td>
      <td width="60%"><%= Ident.getSubmitTime() %></td>
    </tr>
    <tr> 
      <td width="40%" align="right"><span class="style2">交货时间：</span></td>
      <td width="60%"><%= Ident.getConsignmentTime() %>&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" align="right"><span class="style2">总金额：</span></td>
      <td width="60%"><%= Ident.getTotalPrice() %>&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" align="right"><span class="style2">下单时IP：</span></td>
      <td width="60%"><%= Ident.getIPAddress() %>&nbsp;</td>
    </tr>
    <tr> 
      <td width="40%" align="right"><span class="style2">用户备注：</span></td>
      <td width="60%"><%= strFormat.toHtml(Ident.getContent()) %>&nbsp;</td>
    </tr>
	<form name="form1" method="post" action="indentlist.jsp" >
    <tr> 
      <td width="40%" align="right"><span class="style2">是否付款：</span></td>
      <td width="60%"> 
        <input type="radio" name="payoff" value="1" <%if (!Ident.getIsPayoff()) out.print("checked") ; %>>
        否<input type="radio" name="payoff" value="2" <%if (Ident.getIsPayoff()) out.print("checked") ; %>>
        是</td>
    </tr>
    <tr> 
      <td width="40%" align="right"><span class="style2">是否交货：</span></td>
      <td width="60%"> 
        <input type="radio" name="sales" value="1" <%if (!Ident.getIsSales()) out.print("checked") ; %>>
        否<input type="radio" name="sales" value="2" <%if (Ident.getIsSales()) out.print("checked") ; %>>
        是</td>
    </tr>
    <tr>
      <td width="40%" align="right"><span class="style2"></span></td>
      <td width="60%">
		<input type="hidden" name="indentid" value="<%= Id %>">
        <input type="submit" name="submit" value="更新">
      </td>
    </tr>
  </form>
  </table>
  <br>

<% } %>
  <br><p><a href="javascript:window.close()">关闭窗口</a></p>
</div>
</body>
</html>
<%mybook.close();
myIndentlist.close();
user.close();%>