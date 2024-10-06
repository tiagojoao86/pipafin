package br.com.grupopipa.financeiro.dto.data;

import br.com.grupopipa.financeiro.enumeration.LogicOperatorsEnum;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.util.ObjectUtils;

import java.util.List;
import java.util.Optional;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public abstract class FilterDTO {

    @NotNull(message = "operator field cannot be null")
    private LogicOperatorsEnum operator;

}