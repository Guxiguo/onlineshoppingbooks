<%@ page contentType="text/html; charset=gb2312" %>
<html><style type="text/css">
<!--
body {
	background-color: #666666;
}
.style1 {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 66px;
}
.style2 {color: #FF0000}
.style3 {font-size: 60px}
-->
</style>
<!--
  Copyright (c) 1999 The Apache Software Foundation.  All rights 
  reserved.
-->

<title>Nuclear Launch Detected</title><body>

	<p align="center" class="style1 style2 style3">Warning！！！</p>
	<p>&nbsp;</p>
	<p>
	  <%@ page isErrorPage="true" %>
<h1>
    此提示 <%= exception.getMessage() %> 说明你做了错误的选择！！！
   </p>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:window.close()">关闭窗口</a>
</body>
</html>
