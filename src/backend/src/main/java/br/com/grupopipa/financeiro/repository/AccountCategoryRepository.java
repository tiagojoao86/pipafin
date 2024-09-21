package br.com.grupopipa.financeiro.repository;

import br.com.grupopipa.financeiro.entity.AccountCategoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface AccountCategoryRepository extends JpaRepository<AccountCategoryEntity, UUID> {
}
