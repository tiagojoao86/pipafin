package br.com.grupopipa.financeiro.entity.base;

import br.com.grupopipa.financeiro.config.Session;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@MappedSuperclass
@Getter
public abstract class BaseEntity<D> {
    
    @Setter
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID id;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private String createdBy;
    private String updatedBy;

    public BaseEntity() {}

    @PrePersist
    public void create() {
        LocalDateTime now = LocalDateTime.now();
        this.createdAt = now;
        this.updatedAt = now;
        this.createdBy = Session.getUser();
        this.updatedBy = Session.getUser();
    }

    @PreUpdate
    public void update() {
        this.updatedAt = LocalDateTime.now();
        this.updatedBy = Session.getUser();
    }

    public abstract void fillFromDTO(D item);
}