package br.com.grupopipa.financeiro.entity;

import br.com.grupopipa.financeiro.dto.accountcategory.AccountCategoryDTO;
import br.com.grupopipa.financeiro.entity.base.BaseEntity;
import br.com.grupopipa.financeiro.enumeration.AccountCategoryTypeEnum;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity(name = "accountCategory")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class AccountCategoryEntity extends BaseEntity<AccountCategoryDTO> {

    @Column(nullable = false)
    private String description;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private AccountCategoryTypeEnum type;

    @Override
    public void fillFromDTO(AccountCategoryDTO item) {
        this.setId(item.getId());
        this.setDescription(item.getDescription());
        this.setType(item.getType());
    }
}
