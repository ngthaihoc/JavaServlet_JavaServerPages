package hocng.daoImp;

import java.util.List;

import hocng.dao.UsersDAO;
import hocng.entity.USERS;
import hocng.utils.XJDBC;
import hocng.utils.XQuery;

public class UsersDAOImpl implements UsersDAO {

	String insertUserSQL = "INSERT INTO USERS(Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	String updateUserSQL = "UPDATE USERS SET Password = ?, Fullname = ?, Birthday = ?, Gender = ?, Mobile = ?, Email = ?, Role = ? WHERE Id = ?";
	String deleteUserSQL = "DELETE FROM USERS WHERE Id = ?";
	String findAllUsersSQL = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role FROM USERS";
	String findUserByIdSQL = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role FROM USERS WHERE Id = ?";

	@Override
	public USERS create(USERS entity) {
		Object[] values = { entity.getId(), entity.getPassword(), entity.getFullname(), entity.getBirthday(),
				entity.isGender(), entity.getMobile(), entity.getEmail(), entity.isRole() };
		XJDBC.executeUpdate(insertUserSQL, values);
		return entity;
	}

	@Override
	public void update(USERS entity) {
		Object[] values = { entity.getPassword(), entity.getFullname(), entity.getBirthday(), entity.isGender(),
				entity.getMobile(), entity.getEmail(), entity.isRole(), entity.getId() };
		XJDBC.executeUpdate(updateUserSQL, values);
	}

	@Override
	public void deleteById(String id) {
		new NewsDAOImpl().deleteByAuthor(id);
		XJDBC.executeUpdate(deleteUserSQL, id);
	}

	@Override
	public List<USERS> findAll() {
		return XQuery.getBeanList(USERS.class, findAllUsersSQL);
	}

	@Override
	public USERS findById(String id) {
		try {
			USERS user = XQuery.getSingleBean(USERS.class, findUserByIdSQL, id);
			if (user == null) {
				return null;
			}
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			return findByIdManual(id);
		}
	}

	private USERS findByIdManual(String id) {
		try {
			String sql = "SELECT Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role FROM USERS WHERE Id = ?";
			List<USERS> users = XQuery.getBeanList(USERS.class, sql, id);
			if (users != null && !users.isEmpty()) {
				return users.get(0);
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}