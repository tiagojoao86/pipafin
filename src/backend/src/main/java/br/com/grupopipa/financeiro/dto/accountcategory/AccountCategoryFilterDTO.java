package br.com.grupopipa.financeiro.dto.accountcategory;

import br.com.grupopipa.financeiro.dto.FilterDTO;
import br.com.grupopipa.financeiro.dto.Order;
import br.com.grupopipa.financeiro.enumeration.AccountCategoryTypeEnum;
import br.com.grupopipa.financeiro.enumeration.LogicOperatorsEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AccountCategoryFilterDTO extends FilterDTO {
    private String description;
    private AccountCategoryTypeEnum[] types;
}
