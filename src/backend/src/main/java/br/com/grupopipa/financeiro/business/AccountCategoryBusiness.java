package br.com.grupopipa.financeiro.business;

import br.com.grupopipa.financeiro.dto.AccountCategoryDTO;
import br.com.grupopipa.financeiro.dto.AccountCategoryGridDTO;
import br.com.grupopipa.financeiro.entity.AccountCategoryEntity;
import org.springframework.stereotype.Service;

import java.util.function.IntFunction;

@Service
public class AccountCategoryBusiness extends BaseBusiness<AccountCategoryEntity, AccountCategoryGridDTO,AccountCategoryDTO> {

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
