package edu.skku.wp.database;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.dao.DaoManager;
import com.j256.ormlite.jdbc.JdbcConnectionSource;
import com.j256.ormlite.table.TableUtils;
import edu.skku.wp.model.Bid;
import edu.skku.wp.model.Product;
import edu.skku.wp.model.User;
import edu.skku.wp.model.Wishlist;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class DBManager {
    private static class InstanceHolder {
        public static final DBManager INSTANCE = new DBManager();
    }

    private Map<Class<?>, Dao<?,?>> daoMap = new HashMap<>();

    private DBManager() {
        String classPath = this.getClass().getResource("/").getPath();

        try {
            JdbcConnectionSource dataSource = new JdbcConnectionSource("jdbc:sqlite:" + classPath + "/META-INF/database.sqlite");

            daoMap.put(User.class, DaoManager.createDao(dataSource, User.class));
            daoMap.put(Product.class, DaoManager.createDao(dataSource, Product.class));
            daoMap.put(Bid.class, DaoManager.createDao(dataSource, Bid.class));
            daoMap.put(Wishlist.class, DaoManager.createDao(dataSource, Wishlist.class));

            TableUtils.createTableIfNotExists(dataSource, User.class);
            TableUtils.createTableIfNotExists(dataSource, Product.class);
            TableUtils.createTableIfNotExists(dataSource, Bid.class);
            TableUtils.createTableIfNotExists(dataSource, Wishlist.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Dao getDao(Class<?> clazz) {
        return InstanceHolder.INSTANCE.daoMap.get(clazz);
    }
}
