package br.com.grupopipa.financeiro.repository;

import br.com.grupopipa.financeiro.entity.AccountCategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface AccountCategoryRepository extends JpaRepository<AccountCategoryEntity, UUID> {
}
