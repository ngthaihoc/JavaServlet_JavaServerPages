package hocng.dao;

import java.util.List;

import hocng.entity.NEWS;

public interface NewsDAO extends CurdDAO<NEWS, String> {
	List<NEWS> findHomeNews();

	void deleteByAuthor(String authorId);

	void deleteByCategory(String categoryId);
}
