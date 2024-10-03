package br.com.grupopipa.financeiro.business;

import br.com.grupopipa.financeiro.business.base.BaseBusiness;
import br.com.grupopipa.financeiro.dto.person.PersonDTO;
import br.com.grupopipa.financeiro.dto.person.PersonFilterDTO;
import br.com.grupopipa.financeiro.dto.person.PersonGridDTO;
import br.com.grupopipa.financeiro.entity.PersonEntity;
import br.com.grupopipa.financeiro.repository.PersonRepository;
import jakarta.persistence.criteria.Predicate;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.function.IntFunction;

@Service
public class PersonBusiness extends BaseBusiness<PersonEntity, PersonGridDTO, PersonDTO, PersonFilterDTO, PersonRepository> {
    @Override
    public PersonGridDTO convertEntityToGridObject(PersonEntity item) {
        PersonGridDTO dto = new PersonGridDTO();
        dto.fillFromEntity(item);
        return dto;
    }

    @Override
    public IntFunction<PersonGridDTO[]> createGridObjectArray() {
        return PersonGridDTO[]::new;
    }

    @Override
    public PersonEntity createEntityObject() {
        return new PersonEntity();
    }

    @Override
    public PersonDTO createDtoObject() {
        return new PersonDTO();
    }

    @Override
    public String getEntityClassName() {
        return PersonEntity.class.getName();
    }
}
