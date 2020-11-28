package org.pan.web;

import org.pan.util.strFormat;
import org.pan.web.book.shopuser;

import javax.servlet.http.HttpServletRequest;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

public class usermn extends DataBase {
    private shopuser user = new shopuser();	
    private javax.servlet.http.HttpServletRequest request; 
    private Vector userlist;				
    private int page = 1;					
    private int pageSize=8;					
    private int pageCount =0;				
    private long recordCount =0;			
    private String message = "";		
    private String username = "";			
    private long userid = 0;			
    
    
    public usermn() throws Exception{
        super();
    }
    
    public Vector getUserlist() {
        return userlist;
    }
    
    public String getGbk( String str) {
        try {
            return new String(str.getBytes("ISO8859-1"));
        } catch (Exception e) {
            return str;
        }
    }
    
    
    public boolean getRequest(javax.servlet.http.HttpServletRequest newrequest) {
        boolean flag = false;
        try {
            request = newrequest;
            String ID = request.getParameter("userid");
            if (ID!=null ) {
                userid = 0;
                try {
                    userid = Long.parseLong(ID);
                    user.setId(userid);
                } catch (Exception e) {
                    message = message + "你要修改的用户号出错！";
                }
            }
            
            username = request.getParameter("username");
            if (username==null || username.equals("")) {
                username = "";
                message = message + "用户名为空!";
            }
            user.setUserName(getGbk(username));
            String password = request.getParameter("passwd");
            if (password==null || password.equals("")) {
                password = "";
                message = message + "密码为空!";
            }
            String pwdconfirm = request.getParameter("passconfirm");
            if (!password.equals(pwdconfirm)) {
                message = message + "确认密码不相同!";
            }
            user.setPassWord(getGbk(password));
            String names = request.getParameter("names");
            if (names==null) {
                names = "";
            }
            user.setNames(getGbk(names));
            String sex = request.getParameter("sex");
            user.setSex(getGbk(sex));
            String address = request.getParameter("address");
            if (address == null) {
                address = "";
            }
            user.setAddress(getGbk(address));
            String post = request.getParameter("post");
            if (post == null) {
                post = "";
            }
            user.setPost(getGbk(post));
            String phone = request.getParameter("phone");
            if (phone== null) {
                phone = "";
            }
            user.setPhone(phone);
            String email = request.getParameter("email");
            if (email == null) {
                email = "";
            }
            user.setEmail(getGbk(email));
            String IP = request.getRemoteAddr();
            user.setRegIpAddress(IP);
            if (message.equals("")) {
                flag = true;
            }
            return flag;
        } catch (Exception e) {
            return flag;
        }
    }
    
    public String getSql() {
        sqlStr = "select * from My_Users order by Id";
        return sqlStr;
    }
    
    
    public boolean execute() throws Exception {
        sqlStr = "select count(*) from My_Users";    
        int rscount = pageSize;
        try {
            ResultSet rs1 = stmt.executeQuery(sqlStr);
            if (rs1.next()) recordCount = rs1.getInt(1);
            rs1.close();
        } catch (SQLException e) {
            close();
            return false;
        }
       
        if (recordCount < 1)
            pageCount = 0;
        else
            pageCount = (int)(recordCount - 1) / pageSize + 1;
        
        if (page < 1)
            page = 1;
        else if (page > pageCount)
            page = pageCount;
        
        rscount = (int) recordCount % pageSize;	 
        
        
        sqlStr = "select * from My_Users ";
        if (page == 1) {
            sqlStr = sqlStr + " order by Id desc";
        } else {
            sqlStr = sqlStr + " where Id not in ( select Id from My_Users ORDER BY Id) and Id in " +
                    "(select Id from My_Users ORDER BY Id) " + " order by Id desc";
        }
        try {
            rs = stmt.executeQuery(sqlStr);
            userlist = new Vector();
            while (rs.next()){
                shopuser user = new shopuser();
                user.setId(rs.getLong("Id"));
                user.setUserName(rs.getString("UserName"));
                user.setPassWord(rs.getString("PassWord"));
                user.setNames(rs.getString("Names"));
                user.setSex(rs.getString("Sex"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setPost(rs.getString("Post"));
                user.setEmail(rs.getString("Email"));
                user.setRegTime(rs.getString("RegTime"));
                user.setRegIpAddress(rs.getString("RegIpAddress"));
                userlist.addElement(user);
            }
            rs.close();
            return true;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
        
        
    }
    
    public boolean insert(HttpServletRequest req) throws Exception {
        if (getRequest(req)) {
            sqlStr = "select * from My_Users where UserName = '" + user.getUserName() +"'";
            rs = stmt.executeQuery(sqlStr);
            if (rs.next()) {
                message = message + "该用户名已存在!";
                rs.close();
                return false;
            }
            sqlStr = "insert into `My_Users` (UserName,PassWord,Names,Sex,Address,Phone,Post,Email,RegTime,RegIpaddress) values ('";
            sqlStr = sqlStr + strFormat.toSql(user.getUserName()) + "','";
            sqlStr = sqlStr + strFormat.toSql(user.getPassWord()) + "','";
            sqlStr = sqlStr + strFormat.toSql(user.getNames()) + "','";
            sqlStr = sqlStr + strFormat.toSql(user.getSex()) + "','";
            sqlStr = sqlStr + strFormat.toSql(user.getAddress()) + "','";
            sqlStr = sqlStr + strFormat.toSql(user.getPhone()) + "','";
            sqlStr = sqlStr + strFormat.toSql(user.getPost()) + "','";
            sqlStr = sqlStr + strFormat.toSql(user.getEmail()) + "',now(),'";
            sqlStr = sqlStr + user.getRegIpAddress() + "')";
          
              try {
                stmt.execute(sqlStr);
                sqlStr = "select max(Id) from My_Users where UserName = '" +user.getUserName()+ "'";
                rs = stmt.executeQuery(sqlStr);
                while (rs.next()) {
                    userid = rs.getLong(1);
                }
                rs.close();
                return true;
            } catch (SQLException sqle) {
                System.out.println(sqle.toString());
                return false;
            }
        } else	{
            return false;
        }
        
    }
    
    public boolean update(HttpServletRequest req) throws Exception {
        if (getRequest(req)){
            sqlStr = "update My_Users set ";
            sqlStr = sqlStr + "UserName = '" + strFormat.toSql(user.getUserName()) + "',";
            sqlStr = sqlStr + "PassWord = '" + strFormat.toSql(user.getPassWord()) + "',";
            sqlStr = sqlStr + "Names = '" + strFormat.toSql(user.getNames()) + "',";
            sqlStr = sqlStr + "Sex = '" + strFormat.toSql(user.getSex()) + "',";
            sqlStr = sqlStr + "Address = '" + strFormat.toSql(user.getAddress()) + "',";
            sqlStr = sqlStr + "Phone = '" + strFormat.toSql(user.getPhone()) + "',";
            sqlStr = sqlStr + "Post = '" + strFormat.toSql(user.getPost()) + "',";
            sqlStr = sqlStr + "Email = '" + strFormat.toSql(user.getEmail()) + "' ";
            sqlStr = sqlStr + " where Id = '" + user.getId() + "'";
            try {
                stmt.execute(sqlStr);
                return true;
            } catch (SQLException e) {
                return false;
            }
        } else {
            return false;
        }
        
    }
    
    public boolean delete( long aid ) throws Exception {
        
        sqlStr = "delete from My_Users where Id = "  + aid ;
        try {
            stmt.execute(sqlStr);
            return true;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }
    
    public boolean getUserinfo(long newid ) throws Exception {
        try {
            sqlStr="select * from My_Users where Id = " + newid ;
            rs = stmt.executeQuery(sqlStr);
            userlist = new Vector();
            while (rs.next()){
                user.setId(rs.getLong("Id"));
                user.setUserName(rs.getString("UserName"));
                user.setPassWord(rs.getString("PassWord"));
                user.setNames(rs.getString("Names"));
                user.setSex(rs.getString("Sex"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setPost(rs.getString("Post"));
                user.setEmail(rs.getString("Email"));
                user.setRegTime(rs.getString("RegTime"));
                user.setRegIpAddress(rs.getString("RegIpAddress"));
                userlist.addElement(user);
            }
            rs.close();
            return true;
        } catch (SQLException e) {
            return false;
        }
        
    }
    
    public int getPage() {			
        return page;
    }
    public void setPage(int newpage) {
        page = newpage;
    }
    
    public int getPageSize(){		
        return pageSize;
    }
    public void setPageSize(int newpsize) {
        pageSize = newpsize;
    }
    
    public int getPageCount() {			
        return pageCount;
    }
    public void setPageCount(int newpcount) {
        pageCount = newpcount;
    }
    
    public long getRecordCount() {
        return recordCount;
    }
    public void setRecordCount(long newrcount) {
        recordCount= newrcount;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String msg) {
        message = msg;
    }
    
    public void setUserid(long uid) {
        userid = uid;
    }
    public long getUserid() {
        return userid;
    }
    
    public void setUserName(String uName) {
        username = uName;
    }
    
    public String getUserName() {
        return username;
    }
};

