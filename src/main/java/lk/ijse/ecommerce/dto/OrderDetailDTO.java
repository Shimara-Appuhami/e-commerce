package lk.ijse.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.sql.Timestamp;
import java.time.LocalDate;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
public class OrderDetailDTO {
    private int id;
    private int order_id;
    private int product_id;
    private int user_id;
    private int quantity;
    private double price;
    private Timestamp date;
    private double total;

    public OrderDetailDTO(int orderId, Timestamp orderDate, int productId, int quantity, double price, double total) {
        this.order_id = orderId;
        this.date = orderDate;
        this.product_id = productId;
        this.quantity = quantity;
        this.price = price;
        this.total = total;
        this.user_id = 0; // Set user_id to 0 for now (will be fetched from the Order table)
    }
}
