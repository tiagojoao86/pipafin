package br.com.grupopipa.financeiro.business;

import br.com.grupopipa.financeiro.business.base.BaseBusiness;
import br.com.grupopipa.financeiro.dto.accountcategory.AccountCategoryDTO;
import br.com.grupopipa.financeiro.dto.accountcategory.AccountCategoryFilterDTO;
import br.com.grupopipa.financeiro.dto.accountcategory.AccountCategoryGridDTO;
import br.com.grupopipa.financeiro.entity.AccountCategoryEntity;
import br.com.grupopipa.financeiro.repository.AccountCategoryRepository;
import br.com.grupopipa.financeiro.repository.DAO.AccountCategoryDAO;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.util.function.IntFunction;

@Service
public class AccountCategoryBusiness extends BaseBusiness<AccountCategoryDAO, AccountCategoryEntity, AccountCategoryGridDTO, AccountCategoryDTO, AccountCategoryFilterDTO, AccountCategoryRepository> {

    @Override
    public AccountCategoryGridDTO convertEntityToGridObject(AccountCategoryEntity item) {
        AccountCategoryGridDTO grid = new AccountCategoryGridDTO();
        grid.fillFromEntity(item);

        return grid;
    }

    @Override
    public IntFunction<AccountCategoryGridDTO[]> createGridObjectArray() {
        return AccountCategoryGridDTO[]::new;
    }

    @Override
    public AccountCategoryEntity createEntityObject() {
        return new AccountCategoryEntity();
    }

    @Override
    public AccountCategoryDTO createDtoObject() {
        return new AccountCategoryDTO();
    }

    @Override
    public String getEntityClassName() {
        return AccountCategoryEntity.class.getName();
    }

}
