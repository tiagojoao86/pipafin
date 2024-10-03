package br.com.grupopipa.financeiro.dto.accountcategory;

import br.com.grupopipa.financeiro.dto.DTO;
import br.com.grupopipa.financeiro.entity.AccountCategoryEntity;
import br.com.grupopipa.financeiro.enumeration.AccountCategoryTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AccountCategoryGridDTO implements DTO<AccountCategoryEntity> {
    private UUID id;
    private String description;
    private AccountCategoryTypeEnum type;

    @Override
    public void fillFromEntity(AccountCategoryEntity entity) {
        this.id = entity.getId();
        this.description = entity.getDescription();
        this.type = entity.getType();
    }
}
