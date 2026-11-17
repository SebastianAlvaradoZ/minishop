package com.tecsup.minishop.dto;

import com.tecsup.minishop.model.Product;

/**
 * Datos que el cliente puede enviar para crear un producto.
 * Solo expone name, price y stock: el id y cualquier otro campo
 * de la entidad quedan fuera del alcance del cliente (java:S4684,
 * prevención de asignación masiva).
 */
public record ProductRequest(String name, Double price, Integer stock) {

    public Product toEntity() {
        return Product.builder()
                .name(name)
                .price(price)
                .stock(stock)
                .build();
    }
}
