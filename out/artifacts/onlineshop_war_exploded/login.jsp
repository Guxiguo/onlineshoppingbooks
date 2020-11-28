<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<jsp:useBean id="alogin" scope="page" class="org.pan.web.login" />
<%
String mesg = "";

if( request.getParameter("username")!=null && !request.getParameter("username").equals("")){
	String username =request.getParameter("username");
	String passwd = request.getParameter("passwd");
	username = new String(username.getBytes("ISO8859-1"));
	passwd = new String(passwd.getBytes("ISO8859-1"));
	alogin.setUsername(username);
	alogin.setPasswd(passwd);
	if (alogin.excute()){
		session.setAttribute("username",username);
		String userid = Long.toString(alogin.getUserid());
		session.setAttribute("userid",userid);
		response.sendRedirect("userinfo.jsp");
		%>
<%	
	}else {
	mesg = "登录出错！"	;
	}
}
%>

<html>
<head>
<title>兴兴购书网--用户登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

 function checkform() {
	if (document.form1.username.value=="" || document.form1.passwd.value==""){
		alert("用户名或密码为不能为空！");
		return false;
	}
	return true;

  }

</script>
<link rel="stylesheet" href="books.css" type="text/css">
<style type="text/css">
<!--
.style1 {color: #FF0000}
body {
	background-color: #44AA88;
}
.style2 {
	color: #FF0066;
	font-size: 16px;
}
.style4 {color: #CC6666}
-->
</style>
</head>
<body text="#000000">
<div align="center">
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td align="center"><img src="images/logo.JPG" width="65" height="65"><br>
     <span class="style1">PFC购书网</span>    </td></td>
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
  <p class="style2">兴兴购书网用户登录</p>
  <% if (!mesg.equals("")){out.println("<p>" + mesg + "</p>");}%>
  <form name="form1" method="post" action="login.jsp">
    <table width="400" border="0" cellpadding="1" cellspacing="1" bgcolor="#999999">
    <tr> 
      <td width="147" align="right">用户名：<br>
      </td>
      <td width="246" valign="top">
          <input type="text" name="username" size="16" maxlength="25">
        </td>
    </tr>
    <tr> 
      <td width="147" align="right">密 &nbsp;码：</td>
      <td width="246" valign="top">
          <input type="password" name="passwd" maxlength="20" size="16">
        </td>
    </tr>
    <tr> 
      <td width="147" align="right">&nbsp;</td>
      <td width="246" valign="top">
          <input type="submit" name="Submit" value="登录" onClick="javascript:return(checkform());">
          <input type="reset" name="Submit2" value="取消">
        </td>
    </tr>
    <tr> 
      <td colspan="2" align="center">
        <p>&nbsp;</p>
        <p><span class="style4">如果您还没有注册，请</span><a href="reg.jsp">注册</a></p>
      </td>
    </tr>
  </table>
  </form>
  <p>&nbsp;</p><table width="70%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center"><span class="style1">兴兴购书网欢迎您的光临！</span><br>      </td>
    </tr>
  </table>
  
</div>
</body>
</html>
