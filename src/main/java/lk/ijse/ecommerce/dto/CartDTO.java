package lk.ijse.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CartDTO {
    private int id;
    private int user_id;
    private ProductDTO product_id;
    private int quantity;
    private double totalPrice;


}
