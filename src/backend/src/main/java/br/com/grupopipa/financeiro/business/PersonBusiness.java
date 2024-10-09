package br.com.grupopipa.financeiro.business;

import br.com.grupopipa.financeiro.business.base.BaseBusiness;
import br.com.grupopipa.financeiro.dto.person.PersonDTO;
import br.com.grupopipa.financeiro.dto.person.PersonFilterDTO;
import br.com.grupopipa.financeiro.dto.person.PersonGridDTO;
import br.com.grupopipa.financeiro.entity.PersonEntity;
import br.com.grupopipa.financeiro.enumeration.DocumentTypeEnum;
import br.com.grupopipa.financeiro.repository.DAO.PersonDAO;
import br.com.grupopipa.financeiro.repository.PersonRepository;
import org.springframework.stereotype.Service;

import java.util.function.IntFunction;

@Service
public class PersonBusiness extends BaseBusiness<PersonDAO, PersonEntity, PersonGridDTO, PersonDTO, PersonFilterDTO, PersonRepository> {

    public boolean verifyDuplicateDocument(String document, DocumentTypeEnum type) {
        return repository.verifyDuplicateDocument(document, type);
    }

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
