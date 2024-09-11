package br.com.grupopipa.financeiro.entity;

import br.com.grupopipa.financeiro.dto.AccountCategorySave;
import br.com.grupopipa.financeiro.enumeration.AccountTypeEnum;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AccountCategory extends EntityBase {

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    private AccountTypeEnum type;

    public void setFromDto(AccountCategorySave dtoSave) {
        this.setId(dtoSave.getId());
        this.setDescription(dtoSave.getDescription());
        this.setType(dtoSave.getType());
    }
}
