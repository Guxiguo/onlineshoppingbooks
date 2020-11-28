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
		mesg = "您要找的页码出现错误!";
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
<title>兴兴购书网　选购图书</title>
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
      <span class="style1">兴兴购书网</span></td>
      <br>
    </tr>
  </table>

  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td width="200">&nbsp;</td>
      <td width="55"><a href="index.jsp">首页</a></td>
      <td width="100"><a href="booklist.jsp">在线购物</a></td>
      <td width="100"><a href="shoperlist.jsp">我的购物车</a></td>
      <td width="100"><a href="userinfo.jsp">用户信息</a></td>
      <td><a href="login.jsp">用户登录</a></td>
    </tr>
  </table>
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr valign="top"> 
      <td width="186"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="1">
          <tr> 
            <td width="20">&nbsp;</td>
            <td><span class="style1">本店图书分类：</span></td>
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
            <td align=center><span class="style5">图书查询：</span></td>
          </tr>
		  <tr> 
            <td>关键字：<INPUT TYPE="text" NAME="keyword" size=8 maxlength=40 value="<%= keyword %>"></td>
          </tr>
          <tr>
		  <td>类别:
		    <SELECT NAME="classid">
				<option value="">所有类别</option>			
		 
		  <%
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>		    
            <option value="<%= bc.getId()%>"><%= bc.getClassName() %></option>
          <%		}			
%></SELECT>
		    </td>
          </tr>
          <tr> 
            <td align="center"><INPUT TYPE="submit" name="submit" value="查询" ></td>
          </tr>		  
    </FORM>
        </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </td>
      <td align="center"> 
        <p><br>
          <span class="style2">电子书店图书<%= classname %>列表</span></p>
		  <%if (!keyword.equals("")) out.println("<p ><font color=#ff0000>你要查找关于&nbsp;" + keyword + "&nbsp;的图书如下</font></p>"); %>
        <table width="100%" border="1" cellspacing="1" cellpadding="1" bordercolor="#CC9966">
          <tr align="center"> 
            <td><span class="style4">图书名称</span></td>
            <td><span class="style4">作者</span></td>
            <td><span class="style4">图书类别</span></td>
            <td><span class="style4">出版社</span></td>
            <td><span class="style4">单价</span></td>
            <td width=110><span class="style4">选择</span></td>
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
            <td align="center"><%= bk.getPrince() %>元</td>
            <td align="center"><a href="#" onClick="openScript('purchase.jsp?bookid=<%= bk.getId() %>','pur',300,250)" >购买</a>&nbsp;
			<a href="#" onClick="openScript('showbook.jsp?bookid=<%= bk.getId() %>','show',400,450)" >详细资料</a></td>
          </tr>
<%		} 
	}else { 
		if (keyword.equals("")){
			out.println("<tr><td align='center' colspan=6>&nbsp;暂时没有此类图书资料</td></tr>");
		} else {
			out.println("<tr><td align='center' colspan=6>&nbsp;没有你要查找的&nbsp;" + keyword + "&nbsp;相关图书</td></tr>")	;
		}
	}
} else {%>
          <tr>            
            <td align="center" colspan=6>&nbsp;数据库出错，请稍后</td>
            
          </tr>
<% } %>

        </table>
        <table width="90%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td align="right">总计结果为<%= book_list.getRecordCount() %>条，当前页第<%= book_list.getPage() %>页　<a href="booklist.jsp?classid=<%= classid%>&keyword=<%= keyword %>">首页</a>&nbsp; 
              <% if (book_list.getPage()>1) {%>
              <a href="booklist.jsp?page=<%= book_list.getPage()-1 %>&classid=<%= classid%>&keyword=<%= keyword %>">上一页</a>&nbsp; 
              <% } %>
              <% if (book_list.getPage()<book_list.getPageCount()-1) {%>
              <a href="booklist.jsp?page=<%= book_list.getPage()+1 %>&classid=<%= classid%>&keyword=<%= keyword %>">下一页</a>&nbsp; 
              <% } %>
              <a href="booklist.jsp?page=<%= book_list.getPageCount() %>&classid=<%= classid%>&keyword=<%= keyword %>">末页</a>&nbsp;</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="70%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center"><span class="style1">兴兴购书网欢迎您的光临！</span><br>      </td>
    </tr>
  </table>
  
</div>
</body>
</html>
<% book_list.close();%>