package br.com.grupopipa.financeiro.exception;

import java.util.UUID;

public class EntityNotFoundException extends RuntimeException {

    public EntityNotFoundException(String className, UUID id) {
        super(String.format("Cannot found entity '%s' with id '%s'", className, id));
    }

}
