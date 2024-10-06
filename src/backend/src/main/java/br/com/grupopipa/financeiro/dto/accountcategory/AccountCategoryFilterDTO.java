package br.com.grupopipa.financeiro.dto.accountcategory;

import br.com.grupopipa.financeiro.dto.data.FilterDTO;
import br.com.grupopipa.financeiro.enumeration.AccountCategoryTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AccountCategoryFilterDTO extends FilterDTO {
    private String description;
    private AccountCategoryTypeEnum[] types;
}
