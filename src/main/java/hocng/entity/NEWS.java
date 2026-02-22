package hocng.entity;

import java.util.Date;

public class NEWS {
	String id;
	String Title;
	String Content;
	String Image;
	Date PostedDate;
	String Author;
	Integer ViewCount;
	String CategoryId;
	boolean Home;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return Title;
	}

	public void setTitle(String title) {
		Title = title;
	}

	public String getContent() {
		return Content;
	}

	public void setContent(String content) {
		Content = content;
	}

	public String getImage() {
		return Image;
	}

	public void setImage(String image) {
		Image = image;
	}

	public Date getPostedDate() {
		return PostedDate;
	}

	public void setPostedDate(Date postedDate) {
		PostedDate = postedDate;
	}

	public String getAuthor() {
		return Author;
	}

	public void setAuthor(String author) {
		Author = author;
	}

	public Integer getViewCount() {
		return ViewCount;
	}

	public void setViewCount(Integer viewCount) {
		ViewCount = viewCount;
	}

	public String getCategoryId() {
		return CategoryId;
	}

	public void setCategoryId(String categoryId) {
		CategoryId = categoryId;
	}

	public NEWS() {
		super();
	}

	public boolean isHome() {
		return Home;
	}

	public void setHome(boolean home) {
		Home = home;
	}
}
