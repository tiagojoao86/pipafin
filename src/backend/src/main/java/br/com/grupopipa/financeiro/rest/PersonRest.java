package br.com.grupopipa.financeiro.rest;

import br.com.grupopipa.financeiro.dto.person.PersonDTO;
import br.com.grupopipa.financeiro.dto.person.PersonFilterDTO;
import br.com.grupopipa.financeiro.dto.person.PersonGridDTO;
import br.com.grupopipa.financeiro.entity.PersonEntity;
import br.com.grupopipa.financeiro.repository.PersonRepository;
import br.com.grupopipa.financeiro.rest.base.BaseRest;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static br.com.grupopipa.financeiro.enumeration.Constants.R_PERSON;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(R_PERSON)
public class PersonRest extends BaseRest<PersonEntity, PersonGridDTO, PersonDTO, PersonFilterDTO, PersonRepository> {
}
