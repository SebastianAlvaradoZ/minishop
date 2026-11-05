package com.tecsup.minishop.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

/**
 * Convierte las excepciones no controladas en una respuesta HTTP 500.
 * Sin esta clase, MockMvc relanza la excepción como ServletException
 * y la prueba "shouldReturn500WhenProductNotFound" termina en error
 * en lugar de recibir el código de estado 5xx.
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<Map<String, String>> handleRuntimeException(RuntimeException ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(Map.of("error", ex.getMessage()));
    }
}
