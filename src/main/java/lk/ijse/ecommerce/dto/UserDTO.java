package lk.ijse.ecommerce.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class UserDTO {
    private int id;
    private String username;
    private String password;
    private String email;
    private String role;
    private boolean active;

}
