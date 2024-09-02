package br.com.grupopipa.financeiro.entity;

import java.time.LocalDateTime;

import br.com.grupopipa.financeiro.enumeration.AccountTypeEnum;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import lombok.Getter;

@Entity
@Getter
public class Account extends EntityBase {

    @Column(nullable = false)
    private String description;

    @ManyToOne
    private AccountCategory category;

    @Column(nullable = false)
    private double value;

    @Column(nullable = false)
    private LocalDateTime issueDate;

    @Column(nullable = false)
    private LocalDateTime dueDate;

    @Column(nullable = false)
    private AccountTypeEnum type;
    
}
