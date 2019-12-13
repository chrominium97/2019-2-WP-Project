package edu.skku.wp.database;

import org.sqlite.SQLiteDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class DBManager {
    private static class InstanceHolder {
        public static final DBManager INSTANCE = new DBManager();
    }

    private SQLiteDataSource dataSource;
    private Connection conn;

    private DBManager() {
        dataSource = new SQLiteDataSource();
        dataSource.setUrl("jdbc:sqlite:${catalina.base}/skku_wp_project/WEB-INF/database.sqlite");
        try (Connection conn = dataSource.getConnection()) {
            this.conn = conn;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static DBManager getInstance() {
        return InstanceHolder.INSTANCE;
    }

    private static Connection getConnection() {
        return getInstance().conn;
    }
}
