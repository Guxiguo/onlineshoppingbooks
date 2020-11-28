<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%

String username = (String)session.getAttribute("username");
if ( username == null || username.equals("") ){
	response.sendRedirect("login.jsp?msg=nologin");
}

%>

<%@ page import="org.pan.web.book.indent" %>
<jsp:useBean id="my_indent" scope="page" class="org.pan.web.purchase" />

<%
String mesg = "";
String Uid = (String) session.getAttribute("userid");
long uid = 0;
try {
	uid = Long.parseLong(Uid);
} catch (Exception e) {
	uid =0;
	mesg = "���ֲ���Ԥ֪����!";
}
if (!my_indent.getIndent(uid))
	mesg = "���ڱ�վ��û�й����ͼ�顣"	;
%>

<html>
<head>
<title>���˹�����������Ϣ</title>
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
	font-weight: bold;
	font-size: 16px;
}
.style3 {color: #336633}
-->
</style></head>

<body text="#000000">
<div align="center">
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td align="center"><img src="images/logo.JPG" width="65" height="65"><br>
      <span class="style1">���˹�����</span></td>
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
            <td><img src="images/v3_sun_logo.gif" width="88" height="31"></td>
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
        <p><img src="images/modifi.JPG" width="88" height="31"></p>
        <p>&nbsp;</p>
      </td>
      <td align="center"> 
        <p><br>
          <span class="style2">���Ķ�����Ϣ</span></p>
<%if (!mesg.equals("")) {
		out.println("<p><font color=red>" + mesg + "</font></p>");
} else {   %>
        <table width="95%" border="1" cellspacing="2" cellpadding="1" bordercolor="#0066CC">
          <tr align="center"> 
            <td><span class="style3">������</span></td>
            <td><span class="style3">�ύʱ��</span></td>
            <td><span class="style3">�ܽ��</span></td>
            <td><span class="style3">����</span></td>
            <td><span class="style3">����</span></td>
            <td><span class="style3">����</span></td>
          </tr>
	<%for (int i = 0; i<my_indent.getMy_indent().size();i++){
		indent Ident = (indent) my_indent.getMy_indent().elementAt(i);
			%>
          <tr> 
            <td><font color=red><%=Ident.getIndentNo() %></font></td>
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
            <td align="center"><a href="#" onClick="openScript('showindent.jsp?id=<%= Ident.getId() %>&orderno=<%=Ident.getIndentNo() %>','indentlist',500,400);" >�鿴</a></td>
          </tr>
		<%}%>
        </table>
<%} %>
        <p>&nbsp;</p>
      </td>
    </tr>
  </table>

  <table width="70%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center"><span class="style1">���˹�������ӭ���Ĺ��٣�</span><br>      </td>
    </tr>
  </table>
  
</div>
</body>
</html>
