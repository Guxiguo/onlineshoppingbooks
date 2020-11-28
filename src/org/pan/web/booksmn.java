package org.pan.web;
import java.sql.*;
import java.util.Vector;
import org.pan.util.*;
import javax.servlet.http.HttpServletRequest;
import org.pan.web.book.books;
public class booksmn extends DataBase {
	private books abooks = new books();	
	private javax.servlet.http.HttpServletRequest request; 
	private boolean sqlflag = true ;		
	private Vector booklist;				
	private int page = 1;					
	private int pageSize=10;			
	private int pageCount =0;			
	private long recordCount =0;			

	
	public booksmn() throws Exception{
		super();
	}

	public Vector getBooklist() {
		return booklist;
	}

	public boolean getSqlflag() {
		return sqlflag;
	}

	public String getGbk( String str) {
		try
		{
			str =  new String(str.getBytes("ISO-8859-1"),"GBK");
			return str;
		}
		catch (Exception e)
		{
			return str;
		}
	}
	
	
	public boolean getRequest(javax.servlet.http.HttpServletRequest newrequest) {
		boolean flag = false;
		try
		{	
			request = newrequest;
			String ID = request.getParameter("id");
			long bookid = 0;
			try
			{
				bookid = Long.parseLong(ID);
			}
			catch (Exception e)
			{
			}
			abooks.setId(bookid);
			String bookname = request.getParameter("bookname");
			if (bookname==null || bookname.equals(""))
			{
				bookname = "";
				sqlflag = false;
			}
			abooks.setBookName(getGbk(bookname)); 
			String author = request.getParameter("author");
			if (author==null || author.equals(""))
			{	
				author = "";
				sqlflag = false;
			}
			abooks.setAuthor(getGbk(author));
			String publish = request.getParameter("publish");
			if (publish==null)
			{
				publish = "";
			}
			abooks.setPublish(getGbk(publish));
			String bookclass = request.getParameter("bookclass");				
			int bc = Integer.parseInt(bookclass);
			abooks.setBookClass(bc);
			String bookno = request.getParameter("bookno");
			if (bookno == null)
			{
				bookno = "";
			}
			abooks.setBookNo(getGbk(bookno));
			float price;
			try	{
				price =new Float(request.getParameter("price")).floatValue();
			}
			catch (Exception e)
			{	
				price = 0;
				sqlflag = false;
			}
			abooks.setPrince(price);
			int amount;
			try
			{
				amount = new Integer(request.getParameter("amount")).intValue();	
			}
			catch (Exception e)
			{
				sqlflag = false;
				amount = 0;
			} 
			abooks.setAmount(amount);
			String content = request.getParameter("content");
			if (content == null)
			{	
				content = "";
			}
			abooks.setContent(getGbk(content));	
			if (sqlflag)
			{
				flag = true;
			}
			return flag;					
		}
		catch (Exception e)
		{
			return flag;
		}
	}

	public String getSql() {
		sqlStr = "select Id,ClassName from My_Book order by Id";
		return sqlStr;
	}


	public boolean execute(HttpServletRequest res) throws Exception {
		request = res;
		String PAGE = request.getParameter("page");  
		String classid = request.getParameter("classid");	
		String keyword = request.getParameter("keyword");
		if (classid==null) classid="";
		if (keyword==null) keyword = "";
		keyword = getGbk(keyword).toUpperCase();
		try
		{
			page = Integer.parseInt(PAGE);
		}
		catch (NumberFormatException e)
		{
			page = 1;
		}
		 
		
		if (!classid.equals("") && keyword.equals("") ) {		
			sqlStr = "select count(*) from My_Book where BookClass='" + classid + "'";
		} else if (!keyword.equals("")) {
			if (classid.equals(""))
			{
				sqlStr = "select count(*) from My_Book where upper(BookName) like '%" +keyword+ "%' or upper(Content) like '%" + keyword + "%'";
			} else {
				sqlStr = "select count(*) from My_Book where BookClass='" + classid + "' and  (upper(BookName) like '%" +keyword+ "%' or upper(Content) like '%" + keyword + "%')";
			}
		} else {
			sqlStr = "select count(*) from My_Book";   
		}

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

		
		sqlStr = "select  a.Id,a.BookName,a.BookClass,b.ClassName,a.Author,a.Publish,a.BookNo,a.Content,a.Prince,a.Amount,a.Leav_number,a.Regtime from My_Book a,My_BookClass b where a.BookClass = b.Id ";
		if (!classid.equals("") && keyword.equals("") ){  
			if (page == 1)
			{
				sqlStr = sqlStr + " and a.BookClass='" + classid + "' order by a.Id desc";
			} else {
				sqlStr = sqlStr + " and a.BookClass='" + classid + "' and a.Id not in ( select Id from My_Book order by Id ) and a.Id in " +
				"(select Id from My_Book ORDER BY Id )  order by a.Id desc";
			}		
		} else if (!keyword.equals("")) {  
			if (page == 1)
			{
				if (!classid.equals(""))  
				{
					sqlStr = sqlStr + "and a.BookClass='" + classid + "' and (upper(a.BookName) like '%" +keyword+ "%' or upper(a.Content) like '%" + keyword + "%')  order by a.Id desc";
				} else {	
					sqlStr = sqlStr + " and (upper(a.BookName) like '%" +keyword+ "%' or upper(a.Content) like '%" + keyword + "%') order by a.Id desc";
				}
			} else { 
				if (!classid.equals(""))
				{
					sqlStr = sqlStr + " and a.BookClass='" + classid + "' and (upper(a.BookName) like '%" +keyword+ "%' or upper(a.Content) like '%" + keyword + "%') and a.Id not in ( select Id from My_Book ORDER BY Id ) and a.Id in " +
					"(select Id from My_Book ORDER BY Id ) " + " order by a.Id desc";
				} else {
					sqlStr = sqlStr + " and (upper(a.BookName) like '%" +keyword+ "%' or upper(a.Content) like '%" + keyword + "%') and a.Id not in ( select Id from My_Book ORDER BY Id ) and a.Id in " +
					"(select Id from My_Book ORDER BY Id ) " + " order by a.Id desc";
				}
			}	

		} else {		
			if (page == 1)
			{
				sqlStr = sqlStr + "  order by a.Id desc";
			} else {
				sqlStr = sqlStr + " and a.Id not in ( select Id from My_Book ORDER BY Id ) and a.Id in " +
				"(select Id from My_Book ORDER BY Id) order by a.Id desc";
			}		
		}

		try
		{
			rs = stmt.executeQuery(sqlStr);
			booklist = new Vector(rscount);
			while (rs.next())
			{
				books book = new books();
				book.setId(rs.getLong("Id"));//
				book.setBookName(rs.getString("BookName"));//
				book.setBookClass(rs.getInt("BookClass"));//
				book.setClassname(rs.getString("ClassName"));//
				book.setAuthor(rs.getString("Author"));//
				book.setPublish(rs.getString("Publish"));//
				book.setBookNo(rs.getString("BookNo"));//
				book.setContent(rs.getString("Content"));//
				book.setPrince(rs.getFloat("Prince"));//
				book.setAmount(rs.getInt("Amount"));//
				book.setLeav_number(rs.getInt("Leav_number"));//
				book.setRegTime(rs.getString("Regtime"));//
				booklist.addElement(book);
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

               
	public boolean insert() throws Exception {

            sqlStr = "insert into `My_Book` (BookName,BookClass,Author,Publish,Bookno,Content,Prince,Amount,Leav_number,Regtime) values ('";
		sqlStr = sqlStr + strFormat.toSql(abooks.getBookName()) + "','";
		sqlStr = sqlStr + abooks.getBookClass() + "','";
		sqlStr = sqlStr + strFormat.toSql(abooks.getAuthor()) + "','";
		sqlStr = sqlStr + strFormat.toSql(abooks.getPublish()) + "','";
		sqlStr = sqlStr + strFormat.toSql(abooks.getBookNo()) + "','";
		sqlStr = sqlStr + strFormat.toSql(abooks.getContent()) + "','";
		sqlStr = sqlStr + abooks.getPrince() + "','";
		sqlStr = sqlStr + abooks.getAmount() + "','";
		sqlStr = sqlStr + abooks.getAmount() + "',";
		sqlStr = sqlStr + "now())";
		try
		{
			stmt.execute(sqlStr);
			return true;
		}
		catch (SQLException sqle)
		{
			System.out.println(sqle);
			return false;
		}
	}

               
	public boolean update() throws Exception {
		sqlStr = "update My_Book set ";
		sqlStr = sqlStr + "BookName = '" + strFormat.toSql(abooks.getBookName()) + "',";
		sqlStr = sqlStr + "BookClass = '" + abooks.getBookClass() + "',";
		sqlStr = sqlStr + "Author = '" + strFormat.toSql(abooks.getAuthor()) + "',";
		sqlStr = sqlStr + "Publish = '" + strFormat.toSql(abooks.getPublish()) + "',";
		sqlStr = sqlStr + "BookNo = '" + strFormat.toSql(abooks.getBookNo()) + "',";
		sqlStr = sqlStr + "Content = '" + strFormat.toSql(abooks.getContent()) + "',";
		sqlStr = sqlStr + "Prince = '" + abooks.getPrince() + "',";
		sqlStr = sqlStr + "Amount = '" + abooks.getAmount() + "',";
		sqlStr = sqlStr + "Leav_number = '" + abooks.getAmount() + "' ";
		sqlStr = sqlStr + "where Id = '" + abooks.getId() + "'";
		try
		{		
			stmt.execute(sqlStr);
			return true;
		}
		catch (SQLException e)
		{
			return false;
		}
	
	}

	public boolean delete( int aid ) throws Exception {

		sqlStr = "delete from My_Book where Id = "  + aid ;
		try
		{
			stmt.execute(sqlStr);
			return true;
		}
		catch (SQLException e)
		{
			System.out.println(e);
			return false;
		}
	}

	public boolean getOnebook(int newid ) throws Exception {
		try
		{
			sqlStr="select  a.Id,a.BookName,a.BookClass,b.ClassName,a.Author,a.Publish,a.BookNo,a.Content,a.Prince,a.Amount,a.Leav_number,a.Regtime from My_Book a,My_BookClass b where a.BookClass=b.Id and a.Id = " + newid ;
			rs = stmt.executeQuery(sqlStr);
			
			if (rs.next())
			{	booklist = new Vector(1);
				books book = new books();
				book.setId(rs.getLong("Id"));
				book.setBookName(rs.getString("BookName"));
				book.setBookClass(rs.getInt("BookClass"));
				book.setClassname(rs.getString("ClassName"));
				book.setAuthor(rs.getString("Author"));
				book.setPublish(rs.getString("Publish"));
				book.setBookNo(rs.getString("BookNo"));
				book.setContent(rs.getString("Content"));
				book.setPrince(rs.getFloat("Prince"));
				book.setAmount(rs.getInt("Amount"));
				book.setLeav_number(rs.getInt("Leav_number"));
				book.setRegTime(rs.getString("Regtime"));
				booklist.addElement(book);
			} else {
				rs.close();
				return false;
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


};

