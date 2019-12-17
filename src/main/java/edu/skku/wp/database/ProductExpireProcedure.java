package edu.skku.wp.database;

import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.stmt.ColumnArg;
import com.j256.ormlite.stmt.UpdateBuilder;
import com.j256.ormlite.stmt.Where;
import edu.skku.wp.model.Bid;
import edu.skku.wp.model.Product;

import java.sql.SQLException;
import java.util.Comparator;
import java.util.Date;

public class ProductExpireProcedure {

    public static void run() {
        try {
            updateFailed();
            updateSuccessAuction();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static void updateSuccessAuction() throws SQLException {
        Dao<Product, Integer> productDao = DBManager.getDao(Product.class);
        Dao<Bid, Integer> bidDao = DBManager.getDao(Bid.class);
        productDao.queryBuilder().where()
                .le("expireDate", new Date())
                .and()
                .eq("status", Product.Status.AVAILABLE)
                .and()
                .eq("type", Product.Type.AUCTION)
                .and()
                .ne("finalPrice", new ColumnArg("price"))
                .query()
                .stream()
                .forEach(product -> {
                    try {
                        product.setBuyer(
                                bidDao.queryForEq("product_id", product.getId())
                                        .stream()
                                        .max(Comparator.comparingInt(Bid::getPrice))
                                        .map(Bid::getUser)
                                        .orElseThrow()
                        );
                        product.setStatus(Product.Status.SOLD);

                        productDao.update(product);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                });
    }

    private static void updateFailed() throws SQLException {
        Dao<Product, Integer> productDao = DBManager.getDao(Product.class);

        UpdateBuilder<Product, Integer> failedUpdateBuilder = productDao.updateBuilder();
        Where<Product, Integer> w = failedUpdateBuilder.where();

        // Common
        w.le("expireDate", new Date())
                .and()
                .eq("status", Product.Status.AVAILABLE);

        // Auction
        w.eq("type", Product.Type.AUCTION)
                .and()
                .eq("finalPrice", new ColumnArg("price"));

        // Others
        w.ne("type", Product.Type.AUCTION)
                .and()
                .isNull("buyer_id");
        w.or(w, w);
        w.and(w, w);

        failedUpdateBuilder.updateColumnValue("status", Product.Status.FAILED).update();
    }
}
