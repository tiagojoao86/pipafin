package br.com.grupopipa.financeiro.rest;

import lombok.Builder;
import org.springframework.http.HttpStatus;

@Builder
public class Response {

    private HttpStatus status;
    private String messageError;
    private Object body;

    public static Response ok(Object body) {
        return builder().body(body).status(HttpStatus.OK).build();
    }

    public static Response internalServerError(String message) {
        return builder().messageError(message).status(HttpStatus.INTERNAL_SERVER_ERROR).build();
    }

    public static Response notFoundException(String message) {
        return builder().messageError(message).status(HttpStatus.NOT_FOUND).build();
    }

}
