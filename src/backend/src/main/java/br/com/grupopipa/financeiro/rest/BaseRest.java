package br.com.grupopipa.financeiro.rest;

import br.com.grupopipa.financeiro.business.BaseBusiness;
import br.com.grupopipa.financeiro.dto.DTO;
import br.com.grupopipa.financeiro.entity.BaseEntity;
import br.com.grupopipa.financeiro.exception.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;

import static br.com.grupopipa.financeiro.enumeration.Constants.F_ID;
import static br.com.grupopipa.financeiro.enumeration.Constants.PV_ID;
import static br.com.grupopipa.financeiro.enumeration.Constants.R_FIND_BY_ID;
import static br.com.grupopipa.financeiro.rest.Response.internalServerError;
import static br.com.grupopipa.financeiro.rest.Response.notFoundException;
import static br.com.grupopipa.financeiro.rest.Response.ok;

public abstract class BaseRest<T extends BaseEntity<D>, G extends DTO<T>, D extends DTO<T>> {

    @Autowired
    private BaseBusiness<T,G,D> business;

    @GetMapping
    public Response list() {
        try {
            return ok(business.list());
        } catch (Exception e) {
            return internalServerError(e.getMessage());
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
            return notFoundException(e.getMessage());
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
