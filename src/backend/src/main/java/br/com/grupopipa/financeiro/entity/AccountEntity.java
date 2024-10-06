package br.com.grupopipa.financeiro.entity;

import java.time.LocalDateTime;

import br.com.grupopipa.financeiro.dto.account.AccountDTO;
import br.com.grupopipa.financeiro.entity.base.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import lombok.Getter;

@Entity(name = "account")
@Getter
public class AccountEntity extends BaseEntity<AccountDTO> {

    @Column(nullable = false)
    private String description;

    @ManyToOne
    private AccountCategoryEntity category;

    @Column(nullable = false)
    private double value;

    @Column(nullable = false)
    private LocalDateTime issueDate;

    @Column(nullable = false)
    private LocalDateTime dueDate;

    @Override
    public void fillFromDTO(AccountDTO item) {

    }
}
