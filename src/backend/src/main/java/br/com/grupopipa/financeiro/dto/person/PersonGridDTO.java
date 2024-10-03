package br.com.grupopipa.financeiro.dto.person;

import br.com.grupopipa.financeiro.dto.DTO;
import br.com.grupopipa.financeiro.entity.PersonEntity;
import br.com.grupopipa.financeiro.enumeration.PersonTypeEnum;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PersonGridDTO implements DTO<PersonEntity> {

    private UUID id;
    private String name;
    private String fantasyName;
    private PersonTypeEnum personType;

    @Override
    public UUID getId() {
        return this.id;
    }

    @Override
    public void fillFromEntity(PersonEntity entity) {
        this.setId(entity.getId());
        this.setFantasyName(entity.getFantasyName());
        this.setPersonType(entity.getPersonType());
        this.setName(entity.getName());
    }
}
