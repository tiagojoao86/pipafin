package br.com.grupopipa.financeiro.dto;

import br.com.grupopipa.financeiro.entity.AccountCategory;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccountCategoryList {
    private UUID id;
    private String description;

    public AccountCategoryList(AccountCategory entity) {
        this.id = entity.getId();
        this.description = entity.getDescription();
    }
}
