package br.com.grupopipa.financeiro.dto;

import br.com.grupopipa.financeiro.entity.AccountCategoryEntity;
import br.com.grupopipa.financeiro.enumeration.AccountCategoryTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AccountCategoryDTO implements DTO<AccountCategoryEntity> {

    private UUID id;
    private String description;
    private AccountCategoryTypeEnum type;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String createdBy;
    private String updatedBy;

    @Override
    public void fillFromEntity(AccountCategoryEntity entity) {
        this.id = entity.getId();
        this.description = entity.getDescription();
        this.type = entity.getType();
        this.createdAt = entity.getCreatedAt();
        this.createdBy = entity.getCreatedBy();
        this.updatedAt = entity.getUpdatedAt();
        this.updatedBy = entity.getUpdatedBy();
    }
}
