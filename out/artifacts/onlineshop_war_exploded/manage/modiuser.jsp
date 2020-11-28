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

String submit = request.getParameter("submit");
if (submit!=null && !submit.equals("")){		
	if(user.update(request)){		
		mesg = "用户资料修改成功！";	
	}else {
		mesg = "对不起，您提交的参数有错误!"+  user.getMessage();;
	}
}

if (request.getParameter("userid")!=null && !request.getParameter("userid").equals("")) {
	try {
		userid = Long.parseLong(request.getParameter("userid"));
		if (!user.getUserinfo(userid)) {
			mesg = "要修改的用户信息不存在";
		}
	} catch(Exception e) {
		mesg = "该用户号不存在!";
	}
}


%>

<html>
<head>
<title>兴兴购书网管理系统--查看用户详细资料</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="books.css" type="text/css">
<script language="javascript">

function checkform() {
	if (document.form1.username.value==""){
		alert("用户名不能为空");
		document.form1.username.focus();
		return false;
	}
	if (document.form1.passwd.value==""){
		alert("用户密码不能为空");
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
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
.style1 {
	color: #FF0066;
	font-size: 16px;
}
.style2 {
	color: #6633FF;
	font-size: 14px;
}
.style3 {color: #009900}
.style4 {color: #0000FF}
.style5 {color: #FF3399}
-->
</style></head>

<body text="#000000">
<div align="center">
  <p class="style2">修改用户资料</p>
		<% if (!mesg.equals("")){
			out.println("<font color=red>"+ mesg +"</font><br><br>"); 
		} else {
			shopuser userinfo = (shopuser)user.getUserlist().elementAt(0);
		%>
	<table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#FF9966">
	<FORM name="form1" METHOD=POST ACTION="modiuser.jsp">
	  <tr><td align=right width=100><span class="style3">用户名</span></td>
	    <td><input type="text" name="username" maxlength="20" size="14" value="<%= userinfo.getUserName() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">用户密码:</span></td>
		<td><input type="password" name="passwd" maxlength="20" size="14" value="<%= userinfo.getPassWord() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">确认密码:</span></td>
		<td><input type="password" name="passconfirm" maxlength="20" size="14" value="<%= userinfo.getPassWord() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">用户真名</span></td>
		<td> <input type="text" name="names" maxlength="20" size="14" value="<%= userinfo.getNames() %>" ></td></tr>
	  <tr><td align=right width=100><span class="style3">性别</span></td>
	    <td><select name="sex">
            <option <% if (userinfo.getSex().equals("男")) out.print("selected"); %> >男</option>
            <option <% if (userinfo.getSex().equals("女")) out.print("selected"); %> >女</option>
          </select>
		</td></tr> 
	  <tr><td align=right width=100><span class="style3">联系地址</span></td>
		<td><input type="text" name="address" maxlength="150" size="40" value="<%= userinfo.getAddress() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">联系电话</span></td>
		<td><input type="text" name="phone" maxlength="25" size="16" value="<%= userinfo.getPhone() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">邮编</span></td>
		<td><input type="text" name="post" maxlength="8" size="8" value="<%= userinfo.getPost() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">电子邮件</span></td>
		<td><input type="text" name="email" maxlength="50" size="25" value="<%= userinfo.getEmail() %>" ></td></tr> 
	  <tr><td align=right width=100>&nbsp;</td>
		<td><INPUT TYPE="hidden" name="userid" value="<%= userinfo.getId() %>">
			<INPUT TYPE="submit" name="submit" value="修改" onClick="return(checkform());">
			<INPUT TYPE="reset" name="reset" value="取消"></td></tr> 
 </FORM>
  </table>
  <br>
<%}%>
  <br><p><a href="javascript:window.close()">关闭窗口</a></p>
</div>
</body>
</html>
