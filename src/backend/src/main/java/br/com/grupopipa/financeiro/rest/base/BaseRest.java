package br.com.grupopipa.financeiro.rest.base;

import br.com.grupopipa.financeiro.business.base.BaseBusiness;
import br.com.grupopipa.financeiro.dto.DTO;
import br.com.grupopipa.financeiro.dto.data.FilterDTO;
import br.com.grupopipa.financeiro.dto.data.PageableDataRequest;
import br.com.grupopipa.financeiro.entity.base.BaseEntity;
import br.com.grupopipa.financeiro.exception.EntityNotFoundException;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;

import static br.com.grupopipa.financeiro.enumeration.Constants.ENTITY_NOT_FOUND;
import static br.com.grupopipa.financeiro.enumeration.Constants.F_ID;
import static br.com.grupopipa.financeiro.enumeration.Constants.PV_ID;
import static br.com.grupopipa.financeiro.enumeration.Constants.R_FIND_BY_ID;
import static br.com.grupopipa.financeiro.enumeration.Constants.R_QUERY;
import static br.com.grupopipa.financeiro.rest.base.Response.internalServerError;
import static br.com.grupopipa.financeiro.rest.base.Response.notFoundException;
import static br.com.grupopipa.financeiro.rest.base.Response.ok;

@Slf4j
public abstract class BaseRest<T extends BaseEntity<D>, G extends DTO<T>, D extends DTO<T>, F extends FilterDTO, R extends JpaRepository<T, UUID>> {

    @Autowired
    private BaseBusiness<T,G,D,F,R> business;

    @PostMapping(R_QUERY)
    public Response list(@Valid @RequestBody PageableDataRequest<F> pageRequest) {
        try {
            return ok(business.list(pageRequest));
        } catch (Exception e) {
            return internalServerError(String.format("Cause: %s - Message: %s", e.getCause(), e.getMessage()));
        }
    }

    @PostMapping
    public Response save(@RequestBody D body) {
        try {
            return ok(business.save(body));
        } catch (Exception e) {
            return internalServerError(e.getMessage());
        }
    }

    @GetMapping(R_FIND_BY_ID)
    public Response findById(@RequestParam(F_ID) UUID id) {
        try {
            return ok(business.findById(id));
        } catch (EntityNotFoundException e) {
            return ok(String.format(ENTITY_NOT_FOUND, id));
        } catch (Exception e) {
            return internalServerError(e.getMessage());
        }
    }

    @DeleteMapping(PV_ID)
    public Response delete(@PathVariable(F_ID) UUID id) {
        try {
            return ok(business.delete(id));
        } catch (EntityNotFoundException e) {
            return notFoundException(e.getMessage());
        } catch (Exception e) {
            return internalServerError(e.getMessage());
        }
    }

}
