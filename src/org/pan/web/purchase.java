package org.pan.web;

import org.pan.util.strFormat;
import org.pan.web.book.indent;
import org.pan.web.book.indentlist;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;



public class purchase extends DataBase {
	private javax.servlet.http.HttpServletRequest request; 
	private HttpSession session;				
	private boolean sqlflag = true ;			
	private Vector purchaselist;			
	private Vector my_indent;					
	private Vector indent_list;						
	private int booknumber=0;						
	private float all_price=0;						
	private boolean isEmpty=false;				
	private int leaveBook=0;						
	private String IndentNo = "";					
	private boolean isLogin = true;				
	private int page = 1;					
	private int pageSize=15;				
	private int pageCount =0;				
	private long recordCount =0;			


	
	public purchase() throws Exception{
		super();
	}

	public Vector getPurchaselist() {
		return purchaselist;
	}

	public Vector getIndent_list() {
		return indent_list;
	}

	public Vector getMy_indent() {
		return my_indent;
	}

	public boolean getSqlflag() {
		return sqlflag;
	}

	public void setIsEmpty(boolean flag){
		isEmpty = flag;
	}
	public boolean getIsEmpty() {
		return isEmpty;
	}

	public void setLeaveBook(int bknum) {
		leaveBook = bknum;
	}
	public int getLeaveBook() {
		return leaveBook;
	}
	
	public void setIndentNo(String newIndentNo) {
		IndentNo = newIndentNo;
	}

	public String getIndentNo() {
		return IndentNo;
	}

	public void setIsLogin(boolean flag){
		isLogin = flag;
	}
	public boolean getIsLogin() {
		return isLogin;
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

	public String getGbk( String str) {
		try
		{
			return new String(str.getBytes("ISO8859-1"));
		}
		catch (Exception e)
		{
			return str;
		}
	}
	

	public String getSql() {
		sqlStr = "select Id,ClassName from My_Book order by Id";
		return sqlStr;
	}

	public boolean addnew(HttpServletRequest newrequest){
		request = newrequest;
		String ID = request.getParameter("bookid");
		String Amount = request.getParameter("amount");
		long bookid = 0;
		int amount = 0;
		try
		{
			bookid = Long.parseLong(ID);
			amount = Integer.parseInt(Amount);
		}
		catch (Exception e)
		{
			return false;
		}
		if (amount<1) return false;
		session = request.getSession(false);
		if (session == null)
		{
			return false;
		}
		purchaselist = (Vector)session.getAttribute("shopcar");
		sqlStr = "select Leav_number from My_Book where Id=" + bookid;
		try
		{
			rs = stmt.executeQuery(sqlStr);
			if (rs.next())
			{
				if (amount > rs.getInt(1))
				{
					leaveBook = rs.getInt(1);
					isEmpty = true;
					return false;
				}
			}
			rs.close();
		}
		catch (SQLException e)
		{
			return false;
		}

		indentlist iList = new indentlist();
		iList.setBookNo(bookid);
		iList.setAmount(amount);
		boolean match = false;	
		if (purchaselist==null)  
		{
			purchaselist = new Vector();
			purchaselist.addElement(iList);
		}
		
		else { 			
			for (int i=0; i< purchaselist.size(); i++) { 
				indentlist itList= (indentlist) purchaselist.elementAt(i); 
				if ( iList.getBookNo() == itList.getBookNo() ) { 
					itList.setAmount(itList.getAmount() + iList.getAmount()); 
					purchaselist.setElementAt(itList,i); 
					match = true; 
					break;
				} 			
			} 
			if (!match) 
				purchaselist.addElement(iList); 
		}
		session.setAttribute("shopcar", purchaselist); 
		return true;
		
	}

	public boolean modiShoper(HttpServletRequest newrequest) {
		request = newrequest;
		String ID = request.getParameter("bookid");
		String Amount = request.getParameter("amount");
		long bookid = 0;
		int amount = 0;
		try
		{
			bookid = Long.parseLong(ID);
			amount = Integer.parseInt(Amount);
		}
		catch (Exception e)
		{
			return false;
		}
		if (amount<1) return false;
		session = request.getSession(false);
		if (session == null)
		{
			return false;
		}
		purchaselist = (Vector)session.getAttribute("shopcar");
		if (purchaselist==null)
		{
			return false;
		}
		sqlStr = "select Leav_number from My_Book where Id=" + bookid;
		try
		{
			rs = stmt.executeQuery(sqlStr);
			if (rs.next())
			{
				if (amount > rs.getInt(1))
				{
					leaveBook = rs.getInt(1);
					isEmpty = true;
					return false;
				}
			}
			rs.close();
		}
		catch (SQLException e)
		{
			return false;
		}
		for (int i=0; i< purchaselist.size(); i++) { 
			indentlist itList= (indentlist) purchaselist.elementAt(i); 
			if ( bookid == itList.getBookNo() ) { 
				itList.setAmount(amount); 
				purchaselist.setElementAt(itList,i); 
				break;
			} 				
		} 
		return true;
	}



	public boolean delShoper(HttpServletRequest newrequest) {
		request = newrequest;
		String ID = request.getParameter("bookid");
		long bookid = 0;
		try
		{
			bookid = Long.parseLong(ID);
		}
		catch (Exception e)
		{
			return false;
		}
		session = request.getSession(false);
		if (session == null)
		{
			return false;
		}
		purchaselist = (Vector)session.getAttribute("shopcar");
		if (purchaselist==null)
		{
			return false;
		}

		for (int i=0; i< purchaselist.size(); i++) { 
			indentlist itList= (indentlist) purchaselist.elementAt(i); 
			if ( bookid == itList.getBookNo() ) { 
				purchaselist.removeElementAt(i); 
				break;
			}  				
		} 
		return true;
	}

	public boolean payout(HttpServletRequest newrequest) throws Exception {
		request = newrequest;
		session = request.getSession(false);
		if (session == null)
		{
			return false;
		}
		String Userid = (String) session.getAttribute("userid");   
		long userid=0;
		if (Userid==null || Userid.equals(""))
		{
			isLogin = false;
			return false;
		}else {
			try
			{
				userid = Long.parseLong(Userid);
			}
			catch (NumberFormatException e)
			{
				return false;
			}
		}

		purchaselist = (Vector)session.getAttribute("shopcar");
		if (purchaselist==null || purchaselist.size()<0)
		{
			return false;
		}
		String Content = request.getParameter("content");
		if (Content==null)
		{
			Content="";
		}
		Content = getGbk(Content);
		String IP = request.getRemoteAddr();
		String TotalPrice = request.getParameter("totalprice");

		sqlStr = "select max(Id) from My_Indent";
		rs = stmt.executeQuery(sqlStr);
		if (rs.next())
		{
			IndentNo = "HYD" + userid + "" + rs.getString(1);
		} else {
			IndentNo =  "HYD" + userid + "0";
		}
		rs.close();


		sqlStr = "insert into `My_Indent` (IndentNo,UserId,SubmitTime,ConsignmentTime,TotalPrice,Content,IPAddress,IsPayoff,IsSales) values ('";
		sqlStr = sqlStr + IndentNo + "','";
		sqlStr = sqlStr + userid + "',now(),now(),'";
		sqlStr = sqlStr + TotalPrice + "','";
		sqlStr = sqlStr + strFormat.toSql(Content) + "','";
		sqlStr = sqlStr + IP + "',1,1)";
		try
		{
			stmt.execute(sqlStr);
			sqlStr= "select max(Id) from My_Indent where UserId = '" + userid+"'";
			rs = stmt.executeQuery(sqlStr);
			long indentid = 0;
			while (rs.next())
			{
				indentid = rs.getLong(1);
			}
			rs.close();
			for (int i=0; i<purchaselist.size() ;i++ )
			{
				indentlist iList = (indentlist) purchaselist.elementAt(i);

				int newid2 = 1;
				sqlStr = "select max(Id)+1 as newid from My_IndentList";
				rs = stmt.executeQuery(sqlStr);
				if (rs.next())
				{
					newid2 = rs.getInt("newid");
				}

				sqlStr = "insert into `My_IndentList` (IndentNo,BookNo,Amount) values (";
				sqlStr = sqlStr + indentid + ",";
				sqlStr = sqlStr + iList.getBookNo() + ",";
				sqlStr = sqlStr + iList.getAmount() + ")";
				//System.out.println(indentid+iList.getBookNo()+iList.getAmount());
				stmt.execute(sqlStr);
				sqlStr = "update My_Book set Leav_number=Leav_number - " + iList.getAmount() + " where Id = " + iList.getBookNo();
				stmt.execute(sqlStr);
			}
			return true;
		}
		catch (SQLException e)
		{
			return false;
		}
				
	}

	public boolean getIndent(long userid) {
		sqlStr = "select * from My_Indent where UserId = '" +userid+ "' order by Id desc";
		try
		{
			rs = stmt.executeQuery(sqlStr);
			my_indent = new Vector();
			while (rs.next())
			{
				indent ind = new indent();
				ind.setId(rs.getLong("Id"));
				ind.setIndentNo(rs.getString("IndentNo"));
				ind.setUserId(rs.getLong("UserId"));
				ind.setSubmitTime(rs.getString("SubmitTime"));
				ind.setConsignmentTime(rs.getString("ConsignmentTime"));
				ind.setTotalPrice(rs.getFloat("TotalPrice"));
				ind.setContent(rs.getString("Content"));
				ind.setIPAddress(rs.getString("IPAddress"));
				if (rs.getInt("IsPayoff")==1)
					ind.setIsPayoff(false);
				else 
					ind.setIsPayoff(true);
				if (rs.getInt("IsSales")==1)
					ind.setIsSales(false);
				else
					ind.setIsSales(true);
				my_indent.addElement(ind);
			}
			rs.close();
			return true;			
		}
		catch (SQLException e)
		{
			return false;
		}		
	}

	public boolean getOneIndent(long iid) {
		sqlStr = "select * from My_Indent where Id = '" +iid+ "' order by Id desc";
		try
		{
			rs = stmt.executeQuery(sqlStr);
			my_indent = new Vector();
			while (rs.next())
			{
				indent ind = new indent();
				ind.setId(rs.getLong("Id"));
				ind.setIndentNo(rs.getString("IndentNo"));
				ind.setUserId(rs.getLong("UserId"));
				ind.setSubmitTime(rs.getString("SubmitTime"));
				ind.setConsignmentTime(rs.getString("ConsignmentTime"));
				ind.setTotalPrice(rs.getFloat("TotalPrice"));
				ind.setContent(rs.getString("Content"));
				ind.setIPAddress(rs.getString("IPAddress"));
				if (rs.getInt("IsPayoff")==1)
					ind.setIsPayoff(false);
				else 
					ind.setIsPayoff(true);
				if (rs.getInt("IsSales")==1)
					ind.setIsSales(false);
				else
					ind.setIsSales(true);
				my_indent.addElement(ind);
			}
			rs.close();
			return true;			
		}
		catch (SQLException e)
		{
			return false;
		}		
	}

	public boolean getIndent() {
		sqlStr = "select count(*) from My_Indent";  
		int rscount = pageSize;
		try
		{
			ResultSet rs1 = stmt.executeQuery(sqlStr);
			if (rs1.next()) recordCount = rs1.getInt(1);				
			rs1.close();
		}
		catch (SQLException e)
		{
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

	
		sqlStr = "select * from My_Indent ";
		if (page == 1)
		{
			sqlStr = sqlStr + " order by Id desc";
		}else {
			sqlStr = sqlStr + " where Id not in ( select  Id from My_Indent order by Id ) and Id in " +
			"(select Id from My_Indent order by Id ) " + " order by Id desc";
		}

		try
		{
			rs = stmt.executeQuery(sqlStr);
			my_indent = new Vector();
			while (rs.next())
			{
				indent ind = new indent();
				ind.setId(rs.getLong("Id"));
				ind.setIndentNo(rs.getString("IndentNo"));
				ind.setUserId(rs.getLong("UserId"));
				ind.setSubmitTime(rs.getString("SubmitTime"));
				ind.setConsignmentTime(rs.getString("ConsignmentTime"));
				ind.setTotalPrice(rs.getFloat("TotalPrice"));
				ind.setContent(rs.getString("Content"));
				ind.setIPAddress(rs.getString("IPAddress"));
				if (rs.getInt("IsPayoff")==1)
					ind.setIsPayoff(false);
				else 
					ind.setIsPayoff(true);
				if (rs.getInt("IsSales")==1)
					ind.setIsSales(false);
				else
					ind.setIsSales(true);
				my_indent.addElement(ind);
			}
			rs.close();
			return true;			
		}
		catch (SQLException e)
		{
			System.out.println(e);
			return false;
		}		
	}
	
	public boolean getIndentList(long nid) {
		sqlStr = "select * from My_IndentList where IndentNo = '" + nid + "'";
		try
		{	
			rs = stmt.executeQuery(sqlStr);
			indent_list = new Vector();
			while (rs.next())
			{				
				indentlist identlist = new indentlist();
				identlist.setId(rs.getLong("Id"));
				identlist.setIndentNo(rs.getLong("IndentNo"));
				identlist.setBookNo(rs.getLong("BookNo"));
				identlist.setAmount(rs.getInt("Amount"));
				indent_list.addElement(identlist);
			}
			rs.close();
			return true;
		}
		catch (SQLException e)
		{
			return false;
		}		
	}

	public boolean update(HttpServletRequest res) {
		request = res;
		int payoff = 1;
		int sales = 1;
		long indentid =0;
		try
		{
			payoff = Integer.parseInt(request.getParameter("payoff"));
			sales = Integer.parseInt(request.getParameter("sales"));
			indentid = Long.parseLong(request.getParameter("indentid"));
			sqlStr = "update My_Indent set IsPayoff = '" + payoff + "',IsSales='"+ sales +"' where Id =" + indentid;
			stmt.execute(sqlStr);
			return true;
		}
		catch (Exception e)
		{
			return false;
		}		
	}

	public boolean delete(long id) {
		try
		{
			sqlStr = "delete from My_IndentList where IndentNo =" + id;
			stmt.execute(sqlStr);
			sqlStr = "delete from My_Indent where Id= " + id ;
			stmt.execute(sqlStr);
			return true;
		}
		catch (SQLException e)
		{
			return false;
		}
	}

};

