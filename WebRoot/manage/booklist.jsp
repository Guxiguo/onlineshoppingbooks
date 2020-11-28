<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%
if (session.getAttribute("admin")==null || session.getAttribute("admin")==""){
	response.sendRedirect("error.htm");
} %>
<%@ page import="org.pan.web.book.books"%>
<jsp:useBean id="book_list" scope="page" class="org.pan.web.booksmn" />
<%
int pages=1;
String mesg = "";

if (request.getParameter("action")!=null && request.getParameter("action").equals("del")){
	try {
		int delid = Integer.parseInt(request.getParameter("id"));
		if (book_list.delete(delid)){
			mesg = "ɾ���ɹ���";
		} else {
			mesg = "ɾ������";
		}
	} catch (Exception e){
		mesg = "��Ҫɾ���Ķ������!";
	}
}

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "��Ҫ�ҵ�ҳ�����!";
	}
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
.style1 {
	color: #FF3399;
	font-size: 16;
}
.style2 {color: #FF3399; font-size: 16px; }
.style3 {color: #0000FF}
-->
</style></head>

<body text="#000000">
<div align="center">
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
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
        <p class="style1">&nbsp;<% if (!mesg.equals("")) out.println(mesg);%></p>
        <p class="style2">�����������ͼ�����</p>
        <table width="90%" border="1" cellspacing="2" cellpadding="2" bordercolor=#CC0000>
          <tr align="center"> 
            <td>���</td>
            <td>ͼ����</td>
            <td>����</td>
            <td>���</td>
            <td>����</td>
            <td>������</td>
            <td>ʣ����</td>
            <td>����</td>
          </tr>
<% if (book_list.execute(request)) {
	for (int i=0;i<book_list.getBooklist().size();i++){
		books bk = (books) book_list.getBooklist().elementAt(i);
%>
          <tr> 
            <td align="center"><%=bk.getId() %></td>
            <td><a href="#" onClick="openScript('showbook.jsp?bookid=<%= bk.getId() %>','sbook',450,500);"><%= bk.getBookName() %></a></td>
            <td align="center"><%= bk.getAuthor() %></td>
            <td align="center"><%= bk.getClassname() %></td>
            <td align="center"><%= bk.getPrince() %></td>
            <td align="center"><%= bk.getAmount() %></td>
            <td align="center"><%= bk.getLeav_number() %></td>
            <td align="center"><a href="modibook.jsp?id=<%= bk.getId() %>">�޸�</a>&nbsp;&nbsp;<a href="booklist.jsp?action=del&page=<%= pages %>&id=<%= bk.getId() %>" onClick="confirm('���Ҫɾ����');">ɾ��</a></td>
          </tr>
<% }
} else {%>
          <tr> 
            <td align="center" colspan=8><span class="style3">&nbsp;��վ����ά���У����Ժ�......</span></td>
            
          </tr>
<% } %>
        </table>
        <br>
        <table width="85%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td align="right">��ǰҳ��<%= book_list.getPage() %>ҳ��<a href="booklist.jsp">��ҳ</a>&nbsp;
	<% if (book_list.getPage()>1) {%><a href="booklist.jsp?page=<%= book_list.getPage()-1 %>">��һҳ</a>&nbsp;<% } %>
	<% if (book_list.getPage()<book_list.getPageCount()-1) {%><a href="booklist.jsp?page=<%= book_list.getPage()+1 %>">��һҳ</a>&nbsp;<% } %>
				<a href="booklist.jsp?page=<%= book_list.getPageCount() %>">δҳ</a>&nbsp;</td>
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
<% book_list.close();%>