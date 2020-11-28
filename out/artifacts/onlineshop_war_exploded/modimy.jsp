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
		mesg = "��ϲ�����û���Ϣ�޸ĳɹ���";	
	}else {
		mesg = "�Բ������ύ�Ĳ����д���!" +  user.getMessage();;
	}
}
String UserId = (String)session.getAttribute("userid");
if (UserId!=null && !UserId.equals("")) {
	try {
		userid = Long.parseLong(UserId);
		if (!user.getUserinfo(userid)) {
			mesg = "Ҫ�޸ĵ��û���Ϣ������";
		}
	} catch(Exception e) {
		mesg = "���û�������!";
	}
}


%>
<html>
<head>
<title>���˹��������޸ĸ�����Ϣ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function checkform() {
	if (document.form1.username.value==""){
		alert("�û�������Ϊ�գ�");
		document.form1.username.focus();
		return false;
	}
	if (document.form1.passwd.value==""){
		alert("�û����벻��Ϊ�գ�");
		document.form1.passwd.focus();
		return false;
	}
	if (document.form1.passwd.value!=document.form1.passconfirm.value){
		alert("ȷ�����벻�����");
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
      ���˹�����</span> </td></td>
      <br>
    </tr>
  </table>

  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td width="200">&nbsp;</td>
      <td width="55"><a href="index.jsp">��ҳ</a></td>
      <td width="100"><a href="booklist.jsp">���߹���</a></td>
      <td width="100"><a href="shoperlist.jsp">�ҵĹ��ﳵ</a></td>
      <td width="100"><a href="userinfo.jsp">�û���Ϣ</a></td>
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
            <td><a href="userinfo.jsp">�鿴�������</a></td>
          </tr>
          <tr> 
            <td width="20">&nbsp;</td>
            <td><a href="modimy.jsp">�޸ĸ�����Ϣ</a></td>
          </tr>
          <tr>
            <td width="20">&nbsp;</td>
            <td><a href="shoperlist.jsp">�鿴�ҵĹ��ﳵ</a></td>
          </tr>
        </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </td>
      <td align="center"> <br>
        <span class="style1">�޸��ҵĸ�����Ϣ</span><br>
        		<% if (!mesg.equals("")){
			out.println("<br><font color=red>"+ mesg +"</font><br><br>"); 
		} else {
			shopuser userinfo = (shopuser)user.getUserlist().elementAt(0);
		%>
	<FORM name="form1" METHOD=POST ACTION="modimy.jsp">
	<table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#2DAE2D">
	
	  <tr><td align=right width=100><span class="style4">�û���</span></td>
	    <td><%= userinfo.getUserName() %>
		  <input type="hidden" name="username" maxlength="20" size="14" value="<%= userinfo.getUserName() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">�û�����:</span></td>
		<td><input type="password" name="passwd" maxlength="20" size="14" value="<%= userinfo.getPassWord() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">ȷ������:</span></td>
		<td><input type="password" name="passconfirm" maxlength="20" size="14" value="<%= userinfo.getPassWord() %>" ></td></tr> 
	  <tr>
	    <td align=right width=100><span class="style4">�û�����</span></td>
		<td> <input type="text" name="names" maxlength="20" size="14" value="<%= userinfo.getNames() %>" ></td></tr>
	  <tr><td align=right width=100><span class="style4">�Ա�</span></td>
	    <td><select name="sex">
            <option <% if (userinfo.getSex().equals("��")) out.print("selected"); %> >��</option>
            <option <% if (userinfo.getSex().equals("Ů")) out.print("selected"); %> >Ů</option>
          </select>
			</td></tr> 
	  <tr><td align=right width=100><span class="style4">��ϵ��ַ</span></td>
		<td><input type="text" name="address" maxlength="150" size="40" value="<%= userinfo.getAddress() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">��ϵ�绰</span></td>
		<td><input type="text" name="phone" maxlength="25" size="16" value="<%= userinfo.getPhone() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">�ʱ�</span></td>
		<td><input type="text" name="post" maxlength="8" size="8" value="<%= userinfo.getPost() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style4">�����ʼ�</span></td>
		<td><input type="text" name="email" maxlength="50" size="25" value="<%= userinfo.getEmail() %>" ></td></tr> 
	  <tr><td align=right width=100>&nbsp;</td>
		<td><INPUT TYPE="hidden" name="userid" value="<%= userinfo.getId() %>">
			<INPUT TYPE="submit" name="submit" value="�޸�" onClick="return(checkform());">
			<INPUT TYPE="reset" name="reset" value="ȡ��"></td></tr> 
	</FORM>
  </table>
  <br>
<%}%>          
        <p>&nbsp;</p>
</div>
</body>
</html>
