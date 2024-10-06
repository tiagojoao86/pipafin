package br.com.grupopipa.financeiro.dto.data;

import lombok.Builder;
import lombok.Getter;

@Builder
@Getter
public class PageableDataResponse<T> {
    T[] data;
    Long totalRegisters;
}
