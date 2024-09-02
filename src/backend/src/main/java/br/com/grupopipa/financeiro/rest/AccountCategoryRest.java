package br.com.grupopipa.financeiro.rest;

import br.com.grupopipa.financeiro.business.AccountCategoryBusiness;
import br.com.grupopipa.financeiro.dto.AccountCategorySave;
import br.com.grupopipa.financeiro.exception.EntityNotFoundException;
import jakarta.websocket.server.PathParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

import static br.com.grupopipa.financeiro.enumeration.Constants.P_ID;
import static br.com.grupopipa.financeiro.enumeration.Constants.R_ACCOUNT_CATEGORY;
import static br.com.grupopipa.financeiro.rest.Response.internalServerError;
import static br.com.grupopipa.financeiro.rest.Response.notFoundException;
import static br.com.grupopipa.financeiro.rest.Response.ok;

@RestController(R_ACCOUNT_CATEGORY)
public class AccountCategoryRest {

    @Autowired
    private AccountCategoryBusiness business;


    @GetMapping
    public Response list() {
        try {
            return ok(business.list());
        } catch (Exception e) {
            return internalServerError(e.getMessage());
        }
    }

    @PostMapping
    public Response save(AccountCategorySave body) {
        try {
            return ok(business.list());
        } catch (Exception e) {
            return internalServerError(e.getMessage());
        }
    }

    @GetMapping(P_ID)
    public Response findById(@PathParam("id") UUID id) {
        try {
            return ok(business.findById(id));
        } catch (EntityNotFoundException e) {
            return notFoundException(e.getMessage());
        } catch (Exception e) {
            return internalServerError(e.getMessage());
        }
    }

    @DeleteMapping
    public Response delete(UUID id) {
        try {
            return ok(business.delete(id));
        } catch (EntityNotFoundException e) {
            return notFoundException(e.getMessage());
        } catch (Exception e) {
            return internalServerError(e.getMessage());
        }
    }

}
