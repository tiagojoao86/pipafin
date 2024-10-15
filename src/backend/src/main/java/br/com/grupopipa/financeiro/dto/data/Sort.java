package br.com.grupopipa.financeiro.dto.data;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Sort {
    private org.springframework.data.domain.Sort.Direction direction;
    private String property;
}
