package br.com.grupopipa.financeiro.rest.base;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.http.HttpStatus;

@Getter
@Setter
@Builder
public class Response {

    private int statusCode;
    private String errorMessage;
    private Object body;

    public static Response ok(Object body) {
        return builder().body(body).statusCode(HttpStatus.OK.value()).build();
    }

    public static Response ok(String error) {
        return builder().body(null).errorMessage(error).statusCode(HttpStatus.OK.value()).build();
    }

    public static Response internalServerError(String message) {
        return builder().errorMessage(message).statusCode(HttpStatus.INTERNAL_SERVER_ERROR.value()).build();
    }

    public static Response notFoundException(String message) {
        return builder().errorMessage(message).statusCode(HttpStatus.NOT_FOUND.value()).build();
    }

}
