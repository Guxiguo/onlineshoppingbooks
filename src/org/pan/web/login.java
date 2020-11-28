package org.pan.web;

import org.pan.util.strFormat;

public class login extends DataBase
{
  private String username;
  private String passwd;
  private boolean isadmin;
  private long userid = 0L;

  public login()
    throws Exception
  {
    this.username = "";
    this.passwd = "";
    this.isadmin = false;
  }

  public String getUsername() {
    return this.username;
  }
  public void setUsername(String newusername) {
    this.username = newusername;
  }

  public String getPasswd() {
    return this.passwd;
  }
  public void setPasswd(String newpasswd) {
    this.passwd = newpasswd;
  }

  public boolean getIsadmin() {
    return this.isadmin;
  }
  public void setIsadmin(boolean newIsadmin) {
    this.isadmin = newIsadmin;
  }

  public long getUserid() {
    return this.userid;
  }

  public void setUserid(long uid) {
    this.userid = uid;
  }

  public String getSql() {
    if (this.isadmin)
      this.sqlStr = ("select * from My_BookAdminuser where AdminUser = '" + strFormat.toSql(this.username) + "' and AdminPass = '" + strFormat.toSql(this.passwd) + "'");
    else {
      this.sqlStr = ("select * from My_Users where UserName = '" + strFormat.toSql(this.username) + "' and PassWord = '" + strFormat.toSql(this.passwd) + "'");
    }
    return this.sqlStr;
  }

  public boolean excute() throws Exception {
    boolean flag = false;
    this.rs = this.stmt.executeQuery(getSql());
    if (this.rs.next()) {
      if (!this.isadmin)
      {
        this.userid = this.rs.getLong("Id");
      }
      flag = true;
    }
    this.rs.close();
    close();
    return flag;
  }
}