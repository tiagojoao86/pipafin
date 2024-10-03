package br.com.grupopipa.financeiro.repository.DAO;

import br.com.grupopipa.financeiro.dto.accountcategory.AccountCategoryDTO;
import br.com.grupopipa.financeiro.dto.accountcategory.AccountCategoryFilterDTO;
import br.com.grupopipa.financeiro.entity.AccountCategoryEntity;
import br.com.grupopipa.financeiro.enumeration.AccountCategoryTypeEnum;
import br.com.grupopipa.financeiro.repository.AccountCategoryRepository;
import br.com.grupopipa.financeiro.repository.base.BaseDAO;
import org.springframework.stereotype.Repository;
import org.springframework.util.ObjectUtils;

import java.util.Arrays;

@Repository
public class AccountCategoryDAO extends BaseDAO<AccountCategoryDTO, AccountCategoryEntity, AccountCategoryFilterDTO, AccountCategoryRepository> {

    @Override
    protected String addWhereFromFilter(AccountCategoryFilterDTO filter) {
        StringBuilder sb = new StringBuilder();

        if (!ObjectUtils.isEmpty(filter.getDescription())) {
            addWhereClause(sb, String.format("UPPER(description) like '%%%S%%'", filter.getDescription()), filter.getOperator());
        }
        if (!ObjectUtils.isEmpty(filter.getTypes())) {
            addWhereClause(sb,
                    String.format("UPPER(type) in ('%S')",
                    String.join("','", Arrays.stream(filter.getTypes()).map(AccountCategoryTypeEnum::name).toArray(String[]::new))),
                    filter.getOperator());
        }

        return sb.toString();
    }

    @Override
    protected Class<AccountCategoryEntity> getEntityClass() {
        return AccountCategoryEntity.class;
    }

    @Override
    protected String getEntityName() {
        return "accountCategory";
    }
}
