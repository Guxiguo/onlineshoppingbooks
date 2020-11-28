<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%

String username = (String)session.getAttribute("username");
if ( username == null || username.equals("") ){
	response.sendRedirect("login.jsp?msg=nologin");
}

%>

<%@ page import="org.pan.web.book.shopuser" %>
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />
<%
long userid=0;
String mesg = "";

String submit = (String)request.getParameter("submit");
if (submit!=null && !submit.equals("")){		
	if(user.update(request)){		
		mesg = "恭喜您，用户信息修改成功！";	
	}else {
		mesg = "对不起，你提交的参数有错误!" +  user.getMessage();;
	}
}
String UserId = (String)session.getAttribute("userid");
if (UserId!=null && !UserId.equals("")) {
	try {
		userid = Long.parseLong(UserId);
		if (!user.getUserinfo(userid)) {
			mesg = "要修改的用户信息不存在";
		}
	} catch(Exception e) {
		mesg = "该用户不存在!";
	}
}


%>
<html>
<head>
<title>兴兴购书网　修改个人信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function checkform() {
	if (document.form1.username.value==""){
		alert("用户名不能为空！");
		document.form1.username.focus();
		return false;
	}
	if (document.form1.passwd.value==""){
		alert("用户密码不能为空！");
		document.form1.passwd.focus();
		return false;
	}
	if (document.form1.passwd.value!=document.form1.passconfirm.value){
		alert("确认密码不相符！");
		document.form1.passconfirm.focus();
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
	color: #FF33FF;
	font-size: 16px;
}
.style2 {color: #FF0000}
.style4 {color: #006666}
-->
</style></head>

<body text="#000000">
<div align="center">
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td align="center"><span class="style2"><img src="images/logo.JPG" width="65" height="65"><br>
      兴兴购书网</span> </td></td>
      <br>
    </tr>
  </table>

  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td width="200">&nbsp;</td>
      <td width="55"><a href="index.jsp">首页</a></td>
      <td width="100"><a href="booklist.jsp">在线购物</a></td>
      <td width="100"><a href="shoperlist.jsp">我的购物车</a></td>
      <td width="100"><a href="userinfo.jsp">用户信息</a></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  <br>
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr valign="top"> 
      <td width="186" align="center"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="1">
          <tr> 
            <td width="20">&nbsp;</td>
            <td><img src="images/modifi.JPG" width="88" height="31"></td>
          </tr>

          <tr> 
            <td width="20">&nbsp;</td>
            <td><a href="userinfo.jsp">查看订单情况</a></td>
          </tr>
          <tr> 
            <td width="20">&nbsp;</td>
            <td><a href="modimy.jsp">修改个人信息</a></td>
          </tr>
          <tr>
            <td width="20">&nbsp;</td>
            <td><a href="shoperlist.jsp">查看我的购物车</a></td>
          </tr>
        </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </td>
      <td align="center"> <br>
        <span class="style1">修改我的个人信息</span><br>
        		<% if (!mesg.equals("")){
			out.println("<br><font color=red>"+ mesg +"</font><br><br>"); 
		} else {
			shopuser userinfo = (shopuser)user.getUserlist().elementAt(0);
		%>
	<FORM name="form1" METHOD=POST ACTION="modimy.jsp">
	<table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#2DAE2D">
	
	  <tr><td align=right width=100><span class="style4">用户名</span></td>
	    <td><%= userinfo.getUserName() %>
		  <input type="hidden" name="username" maxlength="20" size="14" value="<%= userinfo.getUserName() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">用户密码:</span></td>
		<td><input type="password" name="passwd" maxlength="20" size="14" value="<%= userinfo.getPassWord() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">确认密码:</span></td>
		<td><input type="password" name="passconfirm" maxlength="20" size="14" value="<%= userinfo.getPassWord() %>" ></td></tr> 
	  <tr>
	    <td align=right width=100><span class="style4">用户真名</span></td>
		<td> <input type="text" name="names" maxlength="20" size="14" value="<%= userinfo.getNames() %>" ></td></tr>
	  <tr><td align=right width=100><span class="style4">性别</span></td>
	    <td><select name="sex">
            <option <% if (userinfo.getSex().equals("男")) out.print("selected"); %> >男</option>
            <option <% if (userinfo.getSex().equals("女")) out.print("selected"); %> >女</option>
          </select>
			</td></tr> 
	  <tr><td align=right width=100><span class="style4">联系地址</span></td>
		<td><input type="text" name="address" maxlength="150" size="40" value="<%= userinfo.getAddress() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">联系电话</span></td>
		<td><input type="text" name="phone" maxlength="25" size="16" value="<%= userinfo.getPhone() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">邮编</span></td>
		<td><input type="text" name="post" maxlength="8" size="8" value="<%= userinfo.getPost() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">电子邮件</span></td>
		<td><input type="text" name="email" maxlength="50" size="25" value="<%= userinfo.getEmail() %>" ></td></tr> 
	  <tr><td align=right width=100>&nbsp;</td>
		<td><INPUT TYPE="hidden" name="userid" value="<%= userinfo.getId() %>">
			<INPUT TYPE="submit" name="submit" value="修改" onClick="return(checkform());">
			<INPUT TYPE="reset" name="reset" value="取消"></td></tr> 
	</FORM>
  </table>
  <br>
<%}%>          
        <p>&nbsp;</p>
</div>
</body>
</html>
