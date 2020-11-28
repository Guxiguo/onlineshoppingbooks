<%@ page contentType="text/html; charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="org.pan.web.book.books" %>
<jsp:useBean id="book" scope="page" class="org.pan.web.booksmn" />
<jsp:useBean id="shop" scope="page" class="org.pan.web.purchase" />

<%
String mesg = "";
String submits = request.getParameter("Submit");
int Id=0;
if (submits!=null && !submits.equals("")){
	if (shop.addnew(request)){
		mesg = "ͼ���Ѿ��������Ĺ��ﳵ�У�лл��";
	} else if (shop.getIsEmpty()){
		mesg = "���ͼ���������㣡ֻʣ"+shop.getLeaveBook()+"��";
	} else {
		mesg = "��ʱ���ܹ���";
	}
}else {
	if (request.getParameter("bookid")==null || request.getParameter("bookid").equals("")) {
			mesg = "��Ҫ�����ͼ�鲻���ڣ�";
	} else {
		try {
			Id = Integer.parseInt(request.getParameter("bookid"));
			if (!book.getOnebook(Id)){
				mesg = "��Ҫ�����ͼ�鲻���ڣ�";
			}
		} catch (Exception e){
			mesg = "��Ҫ�����ͼ�鲻���ڣ�";
		}
	}
}
%>
<html>
<head>
<title>���˹�����������ͼ��</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript">

function openScript(url,name, width, height){
	var Win = window.open(url,name,'width=' + width + ',height=' + height + ',resizable=1,scrollbars=yes,menubar=no,status=yes' );
}

function check()
{
	if (document.form1.amount.value<1){
		alert("���Ĺ�����������");
		document.form1.amount.focus();
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
	color: #FF0099;
	font-size: 16px;
}
.style2 {color: #336633}
.style6 {color: #FF0000}
-->
</style></head>

<body text="#000000" onLoad="javascript:window.focus();">
<div align="center">
  <p class="style1">���˹�������ӭ��ѡ��ͼ�飡</p>
   <% if(!mesg.equals("")){
		out.println(mesg);
	  } else {
		books bk = (books) book.getBooklist().elementAt(0);			  
	%>
  <table width="90%" border="0" cellspacing="2" cellpadding="1">
    <form name="form1" method="post" action="purchase.jsp">
      <tr> 
        <td align="center"><span class="style2">ͼ�����ƣ�<%= bk.getBookName() %></span></td>
      </tr>
      <tr align="center"> 
        <td><span class="style2">��Ҫ����������� 
            <input type="text" name="amount" maxlength="4" size="3" value="1"> 
          ��</span></td>
      </tr>
      <tr align="center"> 
        <td>
		  <input type="hidden" name="bookid" value="<%=Id %>">
          <input type="submit" name="Submit" value="�� ��" onClick="return(check());">
          <input type="reset" name="Reset" value="ȡ ��">
        </td>
      </tr>
	   <tr align="center"> 
        <td><a href="#" onClick="openScript('showbook.jsp?bookid=<%= Id %>','show',400,450)" >�鿴��ϸ����</a> </td>
      </tr>
   </form>
  </table>
<% } %>
  <br>
  <p><a href="javascript:window.close()">�رմ���</a></p>
  <table width="100%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center"><span class="style6">���˹�������ӭ���Ĺ��٣�</span><br>      </td>
    </tr>
  </table>
</div>
</body>
</html>
