package br.com.grupopipa.financeiro.dto;

import br.com.grupopipa.financeiro.entity.AccountCategory;
import br.com.grupopipa.financeiro.enumeration.AccountTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AccountCategoryGrid {
    private UUID id;
    private String description;
    private AccountTypeEnum type;

    public AccountCategoryGrid(AccountCategory entity) {
        this.id = entity.getId();
        this.description = entity.getDescription();
        this.type = entity.getType();
    }
}
