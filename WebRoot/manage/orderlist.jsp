<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>

<%@ page import="org.pan.web.book.indent" %>
<%@ page import="org.pan.web.book.shopuser" %>
<jsp:useBean id="shop" scope="page" class="org.pan.web.purchase" />
<jsp:useBean id="user" scope="page" class="org.pan.web.usermn" />

<%
int pages=1;
String mesg = "";
if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try {
		long id = Long.parseLong(request.getParameter("indentid"));
		if (shop.delete(id)) {
			mesg = "ɾ���������ϳɹ���";
		} else {
			mesg = "ɾ����������";
		}
	} catch (Exception e) {
		mesg ="��Ҫɾ�������ݲ�������";
	}
}

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "��Ҫ�ҵ�ҳ�����!";
	}
	shop.setPage(pages);
}
%>
<html>
<head>
<title>���˹���������ϵͳ</title>
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
.style1 {color: #FF0000}
.style2 {
	color: #FF0099;
	font-size: 16pt;
}
.style3 {color: #0000FF}
.style4 {color: #006600}
.style11 {	color: #FF00CC;
	font-size: 16px;
}
-->
</style></head>

<body text="#000000">
<div align="center">
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center" width="18%" valign=top>
        <table width="100%" border="0" cellspacing="2" cellpadding="2">
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
      <td align="center" width="88%">
        <p class="style1">&nbsp;</p>
        <p class="style2">PFC�������������</p>
		<% if (!mesg.equals("")) out.println("<font color=red>" + mesg + "</font><br>");%>
        <table width="98%" border="1" cellspacing="1" cellpadding="1" bordercolor="#FF9966">
          <tr align="center"> 
            <td><span class="style4">�������</span></td>
            <td><span class="style4">�û���</span></td>
            <td><span class="style4">�µ�ʱ��</span></td>
			<td><span class="style4">����ʱ��</span></td>
            <td><span class="style4">�ܽ��</span></td>
			<td><span class="style4">����IP</span></td>
			<td><span class="style4">����</span></td>
            <td><span class="style4">����</span></td>
            <td><span class="style4">�鿴</span></td>
          </tr>
<%
  if (shop.getIndent()) {
		for(int i=0 ; i<shop.getMy_indent().size(); i++){
			indent Ident = (indent) shop.getMy_indent().elementAt(i);	%>
		  <tr>
            <td><%= Ident.getIndentNo() %></td>
            <td align="center"><%
				if (user.getUserinfo(Ident.getUserId()) ) {
					shopuser userinfo = (shopuser)user.getUserlist().elementAt(0); %>
				<a href="#" onClick="openScript('showuser.jsp?userid=<%= Ident.getUserId() %>','showuser',450,500)"><%= userinfo.getUserName() %></a>
			<%} else {
					out.println("���û��ѱ�ɾ��");
				}			
			%></td>
            <td align="center"><%= Ident.getSubmitTime() %></td>
			<td align="center"><%= Ident.getConsignmentTime() %></td>
            <td align="center"><%= Ident.getTotalPrice() %></td>
			<td align="center"><%= Ident.getIPAddress() %></td>
			<td align="center">
			<% if (Ident.getIsPayoff() )
					out.print("�Ѹ���");
				else
					out.print("δ��");
			%></td>
            <td align="center">
			<% if (Ident.getIsSales())
					out.print("�ѷ���");
				else 
					out.print("δ����");
			%></td>
            <td align="center"><a href="#"  onclick="openScript('indentlist.jsp?indentid=<%= Ident.getId() %>','indent',500,500)" >��ϸ���</a>&nbsp;<a href="orderlist.jsp?action=del&indentid=<%= Ident.getId()%>&page=<%= shop.getPage() %>" onClick="return(confirm('�����Ҫɾ����'))">ɾ��</a></td>
          </tr>
<%		}
  }

%>

        </table>
		 <table width="90%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td align="right">��ǰҳ��<%= shop.getPage() %>ҳ��<a href="orderlist.jsp">��ҳ</a>&nbsp; 
              <% if (shop.getPage()>1) {%>
              <a href="orderlist.jsp?page=<%= shop.getPage()-1 %>">��һҳ</a>&nbsp; 
              <% } %>
              <% if (shop.getPage()<shop.getPageCount()-1) {%>
              <a href="orderlist.jsp?page=<%= shop.getPage()+1 %>">��һҳ</a>&nbsp; 
              <% } %>
              <a href="orderlist.jsp?page=<%= shop.getPageCount() %>">δҳ</a>&nbsp;</td>
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
<% shop.close();%>