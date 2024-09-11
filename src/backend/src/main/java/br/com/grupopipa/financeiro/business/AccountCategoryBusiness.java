package br.com.grupopipa.financeiro.business;

import br.com.grupopipa.financeiro.dto.AccountCategoryDto;
import br.com.grupopipa.financeiro.dto.AccountCategoryGrid;
import br.com.grupopipa.financeiro.dto.AccountCategorySave;
import br.com.grupopipa.financeiro.entity.AccountCategory;
import br.com.grupopipa.financeiro.exception.EntityNotFoundException;
import br.com.grupopipa.financeiro.repository.AccountCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.UUID;

@Service
public class AccountCategoryBusiness {

    @Autowired
    private AccountCategoryRepository repository;

    public AccountCategoryGrid[] list() {
        return repository.findAll().stream().map(AccountCategoryGrid::new).toArray(AccountCategoryGrid[]::new);
    }

    public AccountCategoryDto save(AccountCategorySave dto) {
        AccountCategory accountCategory = new AccountCategory();
        accountCategory.setFromDto(dto);

        accountCategory = repository.save(accountCategory);

        return new AccountCategoryDto(accountCategory);
    }

    public AccountCategoryDto findById(UUID id) throws EntityNotFoundException {
        return new AccountCategoryDto(repository.findById(id).orElseThrow(() -> new EntityNotFoundException(AccountCategory.class.getName(), id)));
    }

    public UUID delete(UUID id) throws EntityNotFoundException {
        repository.delete(findEntityById(id));
        return id;
    }

    private AccountCategory findEntityById(UUID id) throws EntityNotFoundException {
        return repository.findById(id).orElseThrow(() -> new EntityNotFoundException(AccountCategory.class.getName(), id));
    }
}
