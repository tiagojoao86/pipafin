package br.com.grupopipa.financeiro.business;

import br.com.grupopipa.financeiro.dto.PersonDTO;
import br.com.grupopipa.financeiro.dto.PersonGridDTO;
import br.com.grupopipa.financeiro.entity.PersonEntity;
import org.springframework.stereotype.Service;

import java.util.function.IntFunction;

@Service
public class PersonBusiness extends BaseBusiness<PersonEntity, PersonGridDTO, PersonDTO> {
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
