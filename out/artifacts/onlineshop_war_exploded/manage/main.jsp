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
.style1 {
	color: #FF0000;
	font-size: 10;
}
.style2 {
	color: #FF0099;
	font-size: 16pt;
}
.style11 {	color: #FF00CC;
	font-size: 16px;
}
-->
</style></head>

<body text="#000000">
<div align="center">
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr> 
      <td colspan="2" align="center">&nbsp;</td>
    </tr>
    <tr>
      <td align="center" width="23%" valign="top"> 
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
      <td align="center" width="77%">
        <p class="style1">&nbsp;</p>
        <p class="style2">���˹��������¶������:</p>

        <table width="90%" border="1" cellspacing="1" cellpadding="1" bordercolor="#336633">
          <tr align="center"> 
            <td>�������</td>
            <td>�û���</td>
            <td>�µ�ʱ��</td>
            <td>�ܽ��</td>
			<td>����</td>
            <td>����</td>
            <td>�鿴</td>
          </tr>
<%
	shop.setPage(1);
  if (shop.getIndent()) {
		for(int i=0 ; i<shop.getMy_indent().size(); i++){
			indent Ident = (indent) shop.getMy_indent().elementAt(i);	%>
		  <tr>
            <td><%= Ident.getIndentNo() %></td>
            <td align="center"><%
				if (user.getUserinfo(Ident.getUserId()) ) {
					try{
					shopuser userinfo = (shopuser)user.getUserlist().elementAt(0);
					out.println(userinfo.getUserName());
					}
					catch(Exception e)
					{out.println("�쳣");
					
				    }
				    }
				 else {
					out.println("���û��ѱ�ɾ��");
				}					
			%></td>
            <td align="center"><%= Ident.getSubmitTime() %></td>
            <td align="center"><%= Ident.getTotalPrice() %></td>
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
            <td align="center"><a href="#"  onclick="openScript('indentlist.jsp?indentid=<%= Ident.getId() %>','indent',500,500)" >��ϸ���</a></td>
          </tr>
<%		}
  } else {
%>
	<tr align=center ><td> ���ִ���</td></tr>
<%}%>
        </table>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>
  <br>
</div>
</body>
</html>
