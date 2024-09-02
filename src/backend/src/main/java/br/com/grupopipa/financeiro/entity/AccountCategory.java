package br.com.grupopipa.financeiro.entity;

import br.com.grupopipa.financeiro.dto.AccountCategorySave;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class AccountCategory extends EntityBase {

    @Column(nullable = false)
    private String description;

    public void setFromDto(AccountCategorySave dtoSave) {
        this.setId(dtoSave.getId());
        this.setDescription(dtoSave.getDescription());
    }
}
