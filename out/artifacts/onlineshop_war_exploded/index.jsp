<%@ page contentType="text/html; charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="org.pan.web.book.bookclass" %>
<%@ page session="true" %>
<jsp:useBean id="classlist" scope="page" class="org.pan.web.bookclasslist" />
<html>
<head>
<title>���˹���������ҳ</title>
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
      <span class="style6">���˹�����</span></td>
    </tr>
  </table>

<table width="750" border="0" cellspacing="1" cellpadding="1">
  <tr>
      <td width="148"><div align="center"></div></td>
      <td width="110"><a href="booklist.jsp">���߹���</a></td>
      <td width="289"><div align="center"><a href="shoperlist.jsp">�ҵĹ��ﳵ</a></div></td>
      <td width="190"><div align="center"><a href="manage/login.jsp">��վ����</a></div></td>
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
        
        <p align="center" class="style6">�û���¼ </p>
        <table width="100%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td align="right">�û�����</td>
            <td><input type="text" name="username" size="8" maxlength="25">            </td>
          </tr>
          <tr>
            <td align="right">�� &nbsp;�룺</td>
            <td><input type="password" name="passwd" size="8" maxlength="20">            </td>
          </tr>
          <tr>
            <td colspan="2" align="center"><input type="submit" name="Submit" value="��¼" >
              <input type="reset" name="Submit2" value="ȡ��">            </td>
          </tr>
          <tr>
            <td colspan="2"><div align="center">�������û��ע�ᣬ��<a href="reg.jsp">ע��</a></div></td>
          </tr>
        </table>  
      </form>
        
        <p align="center">�����û�:<span class="style6"><strong>admin </strong></span></p>
        <p align="center">�������룺<span class="style9">admin</span></p>
      <p>&nbsp;</p></td>
      <td width="362"><div align="center">
        <p class="style7"><br>
            <span class="style8">����ͼ�龫Ʒ</span>          
        </p>
        </div>
        <table width="98%" border="0" cellspacing="1" cellpadding="1">
          <tr>
            <td width="55%"> <strong class="style4">ʹ��JSP����WEBӦ��</strong> </td> 
            <td width="45%" rowspan="2"><div align="center"><img src="images/book.jpg" width="126" height="174" lowsrc="126%20174"></div></td>
          </tr>
          <tr>
            <td width="55%"><p class="style4">���ߣ�


 ����ï ��<br>
    <br>
 ISBN�� 1111111111

</p>
                <p class="style4"> �������ڣ�


 2010-1-1</p>
            <p class="style4"> �����磺�廪��ѧ������  </p></td> 
          </tr>
          <tr> 
            <td colspan="2"> 
              <p>���ݼ�飺</p>
             
              <p align="left">����JSP 2.0�淶���������������Ͳ���JSP��������ǩ�ͱ�ǩ�ļ�������ʹ��JSP��JavaBean�����ʽ���ԣ�EL�����Զ����ǩ�Լ�JSTL��ǩ�ⴴ��WebӦ�ã������Servlet�������WebӦ�õĿ�����������ƻ���MVC����ҵӦ�á�</p>
            <p></p></td>
          </tr>
        </table>
      <p>&nbsp;</p>      </td>
      <td width="167" align="center"> <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="20" height="57">&nbsp;</td>
          <td><span class="style6"><br>����ͼ����ࣺ</span></td>
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
      <span class="style9">���˹�������ӭ���Ĺ��٣�</span><br>      </td>
    </tr>
  </table>
  
</div>
</body>
</html>
