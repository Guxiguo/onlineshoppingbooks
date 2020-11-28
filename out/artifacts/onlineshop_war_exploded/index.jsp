<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="org.pan.web.book.bookclass" %>
<%@ page session="true" %>
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />
<html>
<head>
<title>兴兴购书网　首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">

<link rel="stylesheet" href="books.css" type="text/css">
<style type="text/css">
<!--
body {
	background-color: #FFFFCC;
}
.style4 {color: #669966}
.style6 {color: #FF0000}
.style7 {
	color: #FF0099;
	font-size: 24px;
}
.style8 {font-size: 18px}
.style9 {
	color: #FF0000;
	font-weight: bold;
}
.style10 {
	color: #0000CC;
	font-weight: bold;
}
-->
</style></head>

<body text="#000000">
<div align="center">
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr> 
      <td align="center"><img src="images/logo.JPG" width="63" height="65"><br>
      <span class="style6">兴兴购书网</span></td>
    </tr>
  </table>

<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr>
      <td width="148"><div align="center"></div></td>
      <td width="110"><a href="booklist.jsp">在线购物</a></td>
      <td width="289"><div align="center"><a href="shoperlist.jsp">我的购物车</a></div></td>
      <td width="190"><div align="center"><a href="manage/login.jsp">网站管理</a></div></td>
  </tr>
</table>
<hr>
  <table width="750" border="0" cellspacing="1" cellpadding="1">
    <tr valign="top"> 
      <td width="211"> 
        <p>&nbsp;</p>
        <form name="form1" method="post" action="login.jsp">
          <div align="center"><img src="images/user%20login.JPG" width="80" height="80">
          </div>
        
        <p align="center" class="style6">用户登录 </p>
        <table width="100%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td align="right">用户名：</td>
            <td><input type="text" name="username" size="8" maxlength="25">            </td>
          </tr>
          <tr>
            <td align="right">密 &nbsp;码：</td>
            <td><input type="password" name="passwd" size="8" maxlength="20">            </td>
          </tr>
          <tr>
            <td colspan="2" align="center"><input type="submit" name="Submit" value="登录" >
              <input type="reset" name="Submit2" value="取消">            </td>
          </tr>
          <tr>
            <td colspan="2"><div align="center">如果您还没有注册，请<a href="reg.jsp">注册</a></div></td>
          </tr>
        </table>  
      </form>
        
        <p align="center">管理用户:<span class="style6"><strong>admin </strong></span></p>
        <p align="center">管理密码：<span class="style9">admin</span></p>
      <p>&nbsp;</p></td>
      <td width="362"><div align="center">
        <p class="style7"><br>
            <span class="style8">本店图书精品</span>          
        </p>
        </div>
        <table width="98%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td width="55%"> <strong class="style4">使用JSP开发WEB应用</strong> </td> 
            <td width="45%" rowspan="2"><div align="center"><img src="images/book.jpg" width="126" height="174" lowsrc="126%20174"></div></td>
          </tr>
          <tr>
            <td width="55%"><p class="style4">作者：


 王永茂 著<br>
    <br>
 ISBN： 1111111111

</p>
                <p class="style4"> 出版日期：


 2010-1-1</p>
            <p class="style4"> 出版社：清华大学出版社  </p></td> 
          </tr>
          <tr> 
            <td colspan="2"> 
              <p>内容简介：</p>
             
              <p align="left">掌握JSP 2.0规范技术，包括开发和部署JSP，创建标签和标签文件；联合使用JSP、JavaBean、表达式语言（EL）、自定义标签以及JSTL标签库创建Web应用，最后结合Servlet技术完成Web应用的开发；独立设计基于MVC的企业应用。</p>
            <p></p></td>
          </tr>
        </table>
      <p>&nbsp;</p>      </td>
      <td width="167" align="center"> <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="20" height="57">&nbsp;</td>
          <td><span class="style6"><br>本店图书分类：</span></td>
        </tr>
        <% if (classlist.excute()){
				for (int i=0;i<classlist.getClasslist().size();i++){
					bookclass bc = (bookclass) classlist.getClasslist().elementAt(i); %>
        <tr>
          <td width="20" height="34">&nbsp;</td>
          <td><a href="booklist.jsp?classid=<%= bc.getId()%>"><%= bc.getClassName() %></a></td>
        </tr>
        <%		}			
		}%>
        <tr>
          <td width="20">&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
        <br>
        <form name="form1" method="post" action="login.jsp">
        </form>
      <p>&nbsp;</p>      </td>
    </tr>
  </table>
  <table width="70%" border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="center"><br>        
      <span class="style9">兴兴购书网欢迎您的光临！</span><br>      </td>
    </tr>
  </table>
  
</div>
</body>
</html>
