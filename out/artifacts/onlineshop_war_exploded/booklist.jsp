<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="org.pan.web.book.bookclass" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books"%>
<jsp:useBean id="book" scope="page" class="org.pan.web.book.books" />
<jsp:useBean id="book_list" scope="page" class="org.pan.web.booksmn" />
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />
<%
int pages=1;
String mesg = "";

if (request.getParameter("page")!=null && !request.getParameter("page").equals("")) {
	String requestpage = request.getParameter("page");	
	try {
		pages = Integer.parseInt(requestpage);
	} catch(Exception e) {
		mesg = "��Ҫ�ҵ�ҳ����ִ���!";
	}
	book_list.setPage(pages);
}
String classid = request.getParameter("classid");
String classname ="";
String keyword = request.getParameter("keyword");
if (classid==null) classid="";
if (keyword==null) keyword="";
keyword = book_list.getGbk(keyword);
%>

<html>
<head>
<title>���˹�������ѡ��ͼ��</title>
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
	font-size: 16;
}
.style4 {color: #009900}
.style5 {
	color: #CC33FF;
	font-weight: bold;
}
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
      <td><a href="login.jsp">�û���¼</a></td>
    </tr>
  </table>
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr valign="top"> 
      <td width="186"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="1">
          <tr> 
            <td width="20">&nbsp;</td>
            <td><span class="style1">����ͼ����ࣺ</span></td>
          </tr>
          <% if (classlist.excute()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); 
					if ( classid.equals(Integer.toString(bc.getId())) ) classname=bc.getClassName();
					%>
          <tr> 
            <td width="20">&nbsp;</td>
            <td><a href="booklist.jsp?classid=<%= bc.getId()%>"><%= bc.getClassName() %></a></td>
          </tr>
          <%		}			
		} %>
          <tr> 
            <td width="20">&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
        </table>
		<table width="100%" border="0" cellspacing="1" cellpadding="1">
		  <FORM name=form1 METHOD=POST ACTION="booklist.jsp">
          <tr> 
            <td align=center><span class="style5">ͼ���ѯ��</span></td>
          </tr>
		  <tr> 
            <td>�ؼ��֣�<INPUT TYPE="text" NAME="keyword" size=8 maxlength=40 value="<%= keyword %>"></td>
          </tr>
          <tr>
		  <td>���:
		    <SELECT NAME="classid">
				<option value="">�������</option>			
		 
		  <%
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>		    
            <option value="<%= bc.getId()%>"><%= bc.getClassName() %></option>
          <%		}			
%></SELECT>
		    </td>
          </tr>
          <tr> 
            <td align="center"><INPUT TYPE="submit" name="submit" value="��ѯ" ></td>
          </tr>		  
    </FORM>
        </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </td>
      <td align="center"> 
        <p><br>
          <span class="style2">�������ͼ��<%= classname %>�б�</span></p>
		  <%if (!keyword.equals("")) out.println("<p ><font color=#ff0000>��Ҫ���ҹ���&nbsp;" + keyword + "&nbsp;��ͼ������</font></p>"); %>
        <table width="100%" border="1" cellspacing="1" cellpadding="1" bordercolor="#CC9966">
          <tr align="center"> 
            <td><span class="style4">ͼ������</span></td>
            <td><span class="style4">����</span></td>
            <td><span class="style4">ͼ�����</span></td>
            <td><span class="style4">������</span></td>
            <td><span class="style4">����</span></td>
            <td width=110><span class="style4">ѡ��</span></td>
          </tr>
<% if (book_list.execute(request)) {
	if (book_list.getBooklist().size()>0 ){
		for (int i=0;i<book_list.getBooklist().size();i++){
			books bk = (books) book_list.getBooklist().elementAt(i);%>
          <tr>
            <td><%= bk.getBookName() %></td>
            <td align="center"><%= bk.getAuthor() %></td>
            <td align="center"><%= bk.getClassname() %></td>
            <td align="center"><%= bk.getPublish() %></td>
            <td align="center"><%= bk.getPrince() %>Ԫ</td>
            <td align="center"><a href="#" onClick="openScript('purchase.jsp?bookid=<%= bk.getId() %>','pur',300,250)" >����</a>&nbsp;
			<a href="#" onClick="openScript('showbook.jsp?bookid=<%= bk.getId() %>','show',400,450)" >��ϸ����</a></td>
          </tr>
<%		} 
	}else { 
		if (keyword.equals("")){
			out.println("<tr><td align='center' colspan=6>&nbsp;��ʱû�д���ͼ������</td></tr>");
		} else {
			out.println("<tr><td align='center' colspan=6>&nbsp;û����Ҫ���ҵ�&nbsp;" + keyword + "&nbsp;���ͼ��</td></tr>")	;
		}
	}
} else {%>
          <tr>            
            <td align="center" colspan=6>&nbsp;���ݿ�������Ժ�</td>
            
          </tr>
<% } %>

        </table>
        <table width="90%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td align="right">�ܼƽ��Ϊ<%= book_list.getRecordCount() %>������ǰҳ��<%= book_list.getPage() %>ҳ��<a href="booklist.jsp?classid=<%= classid%>&keyword=<%= keyword %>">��ҳ</a>&nbsp; 
              <% if (book_list.getPage()>1) {%>
              <a href="booklist.jsp?page=<%= book_list.getPage()-1 %>&classid=<%= classid%>&keyword=<%= keyword %>">��һҳ</a>&nbsp; 
              <% } %>
              <% if (book_list.getPage()<book_list.getPageCount()-1) {%>
              <a href="booklist.jsp?page=<%= book_list.getPage()+1 %>&classid=<%= classid%>&keyword=<%= keyword %>">��һҳ</a>&nbsp; 
              <% } %>
              <a href="booklist.jsp?page=<%= book_list.getPageCount() %>&classid=<%= classid%>&keyword=<%= keyword %>">ĩҳ</a>&nbsp;</td>
          </tr>
        </table>
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
<% book_list.close();%>