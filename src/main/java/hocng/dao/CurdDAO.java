package hocng.dao;

import java.util.List;

public interface CurdDAO<T, ID> {
	T create(T entity);

	void update(T entity);

	void deleteById(ID id);

	List<T> findAll();

	T findById(ID id);
}
