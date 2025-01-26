package lk.ijse.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@Setter
@Getter
@AllArgsConstructor
public class ProductDTO {
    private int id;
    private String name;
    private double price;
    private double qty;
    private int category_id;
    private String image_path;

    public ProductDTO(int productId, String s, double v, int i) {
        this.id = productId;
        this.name = s;
        this.price = v;
        this.qty = i;
        this.category_id = 0;

    }
}
