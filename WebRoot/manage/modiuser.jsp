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
		mesg = "�û������޸ĳɹ���";	
	}else {
		mesg = "�Բ������ύ�Ĳ����д���!"+  user.getMessage();;
	}
}

if (request.getParameter("userid")!=null && !request.getParameter("userid").equals("")) {
	try {
		userid = Long.parseLong(request.getParameter("userid"));
		if (!user.getUserinfo(userid)) {
			mesg = "Ҫ�޸ĵ��û���Ϣ������";
		}
	} catch(Exception e) {
		mesg = "���û��Ų�����!";
	}
}


%>

<html>
<head>
<title>���˹���������ϵͳ--�鿴�û���ϸ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="books.css" type="text/css">
<script language="javascript">

function checkform() {
	if (document.form1.username.value==""){
		alert("�û�������Ϊ��");
		document.form1.username.focus();
		return false;
	}
	if (document.form1.passwd.value==""){
		alert("�û����벻��Ϊ��");
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
  <p class="style2">�޸��û�����</p>
		<% if (!mesg.equals("")){
			out.println("<font color=red>"+ mesg +"</font><br><br>"); 
		} else {
			shopuser userinfo = (shopuser)user.getUserlist().elementAt(0);
		%>
	<table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#FF9966">
	<FORM name="form1" METHOD=POST ACTION="modiuser.jsp">
	  <tr><td align=right width=100><span class="style3">�û���</span></td>
	    <td><input type="text" name="username" maxlength="20" size="14" value="<%= userinfo.getUserName() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">�û�����:</span></td>
		<td><input type="password" name="passwd" maxlength="20" size="14" value="<%= userinfo.getPassWord() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">ȷ������:</span></td>
		<td><input type="password" name="passconfirm" maxlength="20" size="14" value="<%= userinfo.getPassWord() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">�û�����</span></td>
		<td> <input type="text" name="names" maxlength="20" size="14" value="<%= userinfo.getNames() %>" ></td></tr>
	  <tr><td align=right width=100><span class="style3">�Ա�</span></td>
	    <td><select name="sex">
            <option <% if (userinfo.getSex().equals("��")) out.print("selected"); %> >��</option>
            <option <% if (userinfo.getSex().equals("Ů")) out.print("selected"); %> >Ů</option>
          </select>
		</td></tr> 
	  <tr><td align=right width=100><span class="style3">��ϵ��ַ</span></td>
		<td><input type="text" name="address" maxlength="150" size="40" value="<%= userinfo.getAddress() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">��ϵ�绰</span></td>
		<td><input type="text" name="phone" maxlength="25" size="16" value="<%= userinfo.getPhone() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">�ʱ�</span></td>
		<td><input type="text" name="post" maxlength="8" size="8" value="<%= userinfo.getPost() %>" ></td></tr> 
	  <tr><td align=right width=100><span class="style3">�����ʼ�</span></td>
		<td><input type="text" name="email" maxlength="50" size="25" value="<%= userinfo.getEmail() %>" ></td></tr> 
	  <tr><td align=right width=100>&nbsp;</td>
		<td><INPUT TYPE="hidden" name="userid" value="<%= userinfo.getId() %>">
			<INPUT TYPE="submit" name="submit" value="�޸�" onClick="return(checkform());">
			<INPUT TYPE="reset" name="reset" value="ȡ��"></td></tr> 
 </FORM>
  </table>
  <br>
<%}%>
  <br><p><a href="javascript:window.close()">�رմ���</a></p>
</div>
</body>
</html>
