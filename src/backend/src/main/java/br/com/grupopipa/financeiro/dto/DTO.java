package br.com.grupopipa.financeiro.dto;

import java.util.UUID;

public interface DTO<T> {

    UUID getId();
    void fillFromEntity(T entity);
}
