package br.com.grupopipa.financeiro.rest;

import br.com.grupopipa.financeiro.dto.AccountCategoryDTO;
import br.com.grupopipa.financeiro.dto.AccountCategoryGridDTO;
import br.com.grupopipa.financeiro.entity.AccountCategoryEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static br.com.grupopipa.financeiro.enumeration.Constants.R_ACCOUNT_CATEGORY;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(R_ACCOUNT_CATEGORY)
public class AccountCategoryRest extends BaseRest<AccountCategoryEntity, AccountCategoryGridDTO, AccountCategoryDTO> {
}
