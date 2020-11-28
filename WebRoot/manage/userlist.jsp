<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="org.pan.web.book.shopuser" %>
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />
<%
int pages=1;
String mesg = "";

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "��Ҫ�ҵ�ҳ�����!";
	}
	user.setPage(pages);
}

if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try{
		long id = Long.parseLong(request.getParameter("userid"));
		if (user.delete(id)) {
			mesg = "ɾ�������ɹ�";
		} else {
			mesg = "ɾ����������";
		}
	} catch (Exception e) {
		mesg = "��Ҫɾ�����û��Ŵ���";
	}
}

%>

<html>
<head>
<title>���˹���������ϵͳ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">
<!--
  function checkform() {
	if (document.form1.username.value=="" || document.form1.passwd.value==""){
		alert("�û���������Ϊ�գ�");
		return false;
	}
	return true;

  }

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}
-->
</script>
<link rel="stylesheet" href="books.css" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
.style1 {color: #FF0000}
.style2 {
	color: #FF0099;
	font-size: 16pt;
}
.style3 {color: #009900}
.style4 {color: #0000FF}
.style11 {	color: #FF00CC;
	font-size: 16px;
}
-->
</style></head>

<body text="#000000">
<div align="center">
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center" width="20%" valign="top">
        <table width="100%" border="0" cellspacing="2" cellpadding="2" >
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td align="center"><a href="main.jsp">�ع�����ҳ</a></td>
          </tr>
          <tr> 
            <td align="center"><a href="booklist.jsp">�̵�ͼ���ѯ</a></td>
          </tr>
          <tr> 
            <td align="center"><a href="addbook.jsp">���ͼ������</a></td>
          </tr>
          <tr> 
            <td align="center"><a href="orderlist.jsp">������Ϣ��ѯ</a></td>
          </tr>
          <tr> 
            <td align="center"><a href="userlist.jsp">�û���Ϣ��ѯ</a></td>
          </tr>
          <tr> 
            <td align="center"><a href="logout.jsp">�˳�</a></td>
          </tr>
        </table>
      </td>
      <td align="center" width="80%">
        <p class="style1">&nbsp;</p>
        <p class="style2">���˹������û����</p>
        <% if (!mesg.equals("")) out.println("<font color=red>"+ mesg +"</font><br><br>");%>
        <table width="95%" border="1" cellspacing="1" cellpadding="1" bordercolor="#FF9966">
          <tr align="center"> 
            <td><span class="style3">�û�ID��</span></td>
            <td><span class="style3">�û���</span></td>
            <td><span class="style3">��ʵ����</span></td>
            <td><span class="style3">��ϵ��ַ</span></td>
            <td><span class="style3">��ϵ�绰</span></td>
			<td><span class="style3">Email</span></td>
			<td><span class="style3">�鿴</span></td>
          </tr>
<% 
if (user.execute()){
	for(int i=0; i<user.getUserlist().size(); i++){
		shopuser userinfo = (shopuser) user.getUserlist().elementAt(i);
%>
          <tr>
            <td align=center><%= userinfo.getId()%></td>
            <td><%= userinfo.getUserName()%></td>
            <td><%= userinfo.getNames()%></td>
            <td><%= userinfo.getAddress()%></td>
            <td><%= userinfo.getPhone()%></td>
			<td><%= userinfo.getEmail()%></td>
            <td align=center><a href="#" onClick="openScript('showuser.jsp?userid=<%= userinfo.getId() %>','showuser',450,500)">��ϸ����</a>&nbsp;<a href="#" onClick="openScript('modiuser.jsp?userid=<%= userinfo.getId() %>','modis',450,500)">�޸�</a>&nbsp;<a href="userlist.jsp?userid=<%= userinfo.getId()%>&page=<%= user.getPage()%>&action=del" onClick="return(confirm('�����Ҫɾ������û�?'))">ɾ��</a></td>
          </tr>
<%	}
}%>

        </table>
		<table width="90%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td align="right">��ǰҳ��<%= user.getPage() %>ҳ��<a href="userlist.jsp">��ҳ</a>&nbsp; 
              <% if (user.getPage()>1) {%>
              <a href="userlist.jsp?page=<%= user.getPage()-1 %>">��һҳ</a>&nbsp; 
              <% } %>
              <% if (user.getPage()<user.getPageCount()-1) {%>
              <a href="userlist.jsp?page=<%= user.getPage()+1 %>">��һҳ</a>&nbsp; 
              <% } %>
              <a href="userlist.jsp?page=<%= user.getPageCount() %>">δҳ</a>&nbsp;</td>
          </tr>
        </table>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
  <br>
</div>
</body>
</html>
