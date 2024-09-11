package br.com.grupopipa.financeiro.dto;

import br.com.grupopipa.financeiro.entity.AccountCategory;
import br.com.grupopipa.financeiro.enumeration.AccountTypeEnum;
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
public class AccountCategoryDto {

    private UUID id;
    private String description;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private AccountTypeEnum type;
    private String createdBy;
    private String updatedBy;

    public AccountCategoryDto(AccountCategory entity) {
        this.id = entity.getId();
        this.description = entity.getDescription();
        this.type = entity.getType();
        this.createdAt = entity.getCreatedAt();
        this.createdBy = entity.getCreatedBy();
        this.updatedAt = entity.getUpdatedAt();
        this.updatedBy = entity.getUpdatedBy();
    }
}
