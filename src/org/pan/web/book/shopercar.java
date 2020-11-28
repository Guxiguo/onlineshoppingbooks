package org.pan.web.book;



public class shopercar {
	private long bookId;		
	private int quanlity;		

	public shopercar(){
		bookId = 0;
		quanlity = 0;
	}

	public long getBookId() {
		return bookId;
	}

	public void setBookId(long newbookId) {
		bookId = newbookId;
	}
	
	public long getQuality() {
		return quanlity;
	}

	public void setQuanlity(int newquanlity) {
		quanlity = newquanlity;
	}
}
