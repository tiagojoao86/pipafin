package br.com.grupopipa.financeiro.repository;

import br.com.grupopipa.financeiro.entity.PersonEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface PersonRepository extends JpaRepository<PersonEntity, UUID> {
}
