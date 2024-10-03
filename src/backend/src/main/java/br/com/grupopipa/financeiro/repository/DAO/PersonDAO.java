package br.com.grupopipa.financeiro.repository.DAO;

import br.com.grupopipa.financeiro.dto.person.PersonDTO;
import br.com.grupopipa.financeiro.dto.person.PersonFilterDTO;
import br.com.grupopipa.financeiro.entity.PersonEntity;
import br.com.grupopipa.financeiro.enumeration.PersonTypeEnum;
import br.com.grupopipa.financeiro.repository.PersonRepository;
import br.com.grupopipa.financeiro.repository.base.BaseDAO;
import org.springframework.stereotype.Repository;
import org.springframework.util.ObjectUtils;

import java.util.Arrays;

@Repository
public class PersonDAO extends BaseDAO<PersonDTO, PersonEntity, PersonFilterDTO, PersonRepository> {

    @Override
    protected String addWhereFromFilter(PersonFilterDTO filter) {
        StringBuilder sb = new StringBuilder();

        if (!ObjectUtils.isEmpty(filter.getName())) {
            addWhereClause(sb, String.format("(UPPER(name) like '%%%S%%' OR UPPER(fantasyName) like '%%%S%%') ",
                    filter.getName(), filter.getName()), filter.getOperator());
        }

        if (!ObjectUtils.isEmpty(filter.getTypes())) {
            addWhereClause(sb,
                    String.format("UPPER(personType) IN ('%s') ",
                    String.join("','", Arrays.stream(filter.getTypes()).map(PersonTypeEnum::name).toArray(String[]::new))),
                    filter.getOperator());
        }

        if (!ObjectUtils.isEmpty(filter.getDocument())) {
            addWhereClause(sb, String.format("UPPER(document) like '%%%S%%' ", filter.getDocument()), filter.getOperator());
        }

        if (!ObjectUtils.isEmpty(filter.getPhone())) {
            addWhereClause(sb, String.format("(phone1 like '%%%S%%' OR phone2 like '%%%S%%') ",
                    filter.getPhone(), filter.getPhone()), filter.getOperator());
        }

        if (!ObjectUtils.isEmpty(filter.getAddress())) {
            addWhereClause(sb, String.format("(UPPER(addressNumber) like '%%%S%%' OR UPPER(addressStreet) like '%%%S%%' OR " +
                            "UPPER(addressCity) like '%%%S%%' OR UPPER(addressState) like '%%%S%%' OR " +
                            "UPPER(addressPostalCode) like '%%%S%%') ",
                    filter.getAddress(), filter.getAddress(), filter.getAddress(), filter.getAddress(), filter.getAddress()),
                    filter.getOperator());
        }

        return sb.toString();
    }

    @Override
    protected Class<PersonEntity> getEntityClass() {
        return PersonEntity.class;
    }

    @Override
    protected String getEntityName() {
        return "person";
    }


}