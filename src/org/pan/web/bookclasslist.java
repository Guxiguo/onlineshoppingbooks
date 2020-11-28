package org.pan.web;

import org.pan.web.book.bookclass;

import java.sql.SQLException;
import java.util.Vector;



public class bookclasslist extends DataBase {
	private Vector classlist;		
	
	public bookclasslist() throws Exception{
		super();
	}

	public Vector getClasslist() {
		return classlist;
	}
        
	
	public String getSql() {

            return "";
	}

	public boolean excute() throws Exception {
		int id = 0;
		String classname = "";
		int rscount = 0;
		try {
			
			rs = stmt.executeQuery("select Id,ClassName from My_BookClass order by Id");
                        rscount = stmt.getMaxRows();
			classlist = new Vector(rscount+1);
			classlist.clear();
			while (rs.next()){				
				id = rs.getInt("Id");
				classname = rs.getString("ClassName");
				bookclass bc = new bookclass(id,classname);
				classlist.addElement(bc);
			}
			rs.close();
			return true;
		}
		catch (SQLException sqle){
			System.out.println(sqle);
            return false;
		}
	}
};

