package br.com.grupopipa.financeiro.rest;

import br.com.grupopipa.financeiro.business.PersonBusiness;
import br.com.grupopipa.financeiro.dto.person.PersonDTO;
import br.com.grupopipa.financeiro.dto.person.PersonFilterDTO;
import br.com.grupopipa.financeiro.dto.person.PersonGridDTO;
import br.com.grupopipa.financeiro.entity.PersonEntity;
import br.com.grupopipa.financeiro.enumeration.DocumentTypeEnum;
import br.com.grupopipa.financeiro.repository.DAO.PersonDAO;
import br.com.grupopipa.financeiro.repository.PersonRepository;
import br.com.grupopipa.financeiro.rest.base.BaseRest;
import br.com.grupopipa.financeiro.rest.base.Response;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

import static br.com.grupopipa.financeiro.enumeration.Constants.F_DOCUMENT;
import static br.com.grupopipa.financeiro.enumeration.Constants.F_DOCUMENT_TYPE;
import static br.com.grupopipa.financeiro.enumeration.Constants.F_ID;
import static br.com.grupopipa.financeiro.enumeration.Constants.R_PERSON;
import static br.com.grupopipa.financeiro.enumeration.Constants.R_VERIFY_DUPLICATE_DOCUMENT;
import static br.com.grupopipa.financeiro.rest.base.Response.internalServerError;
import static br.com.grupopipa.financeiro.rest.base.Response.ok;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(R_PERSON)
public class PersonRest extends BaseRest<PersonBusiness, PersonDAO, PersonEntity, PersonGridDTO, PersonDTO, PersonFilterDTO, PersonRepository> {

    @GetMapping(R_VERIFY_DUPLICATE_DOCUMENT)
    public Response verifyDuplicateDocument(@RequestParam(value = F_ID, required = false) UUID id,
                                            @RequestParam(F_DOCUMENT) String document,
                                            @RequestParam(F_DOCUMENT_TYPE) DocumentTypeEnum type) {
        try {
            return ok(business.verifyDuplicateDocument(id, document, type));
        } catch (Exception e) {
            return internalServerError(e.getMessage());
        }
    }
}
