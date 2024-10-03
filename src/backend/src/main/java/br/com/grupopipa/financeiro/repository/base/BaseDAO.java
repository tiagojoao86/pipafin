package br.com.grupopipa.financeiro.repository.base;

import br.com.grupopipa.financeiro.dto.DTO;
import br.com.grupopipa.financeiro.dto.FilterDTO;
import br.com.grupopipa.financeiro.entity.base.BaseEntity;
import br.com.grupopipa.financeiro.enumeration.LogicOperatorsEnum;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;

public abstract class BaseDAO<D extends DTO<T>, T extends BaseEntity<D>, F extends FilterDTO, R extends JpaRepository<T, UUID>> {

    @Autowired
    R repository;

    @PersistenceContext
    EntityManager em;

    public Optional<T> findById(UUID id) {
        return repository.findById(id);
    }

    public List<T> findAll() {
        return repository.findAll();
    }

    public T save(T entity) {
        return repository.save(entity);
    }

    public void delete(T entity) {
        repository.delete(entity);
    }

    public List<T> findWithFilter(F filter) {
        StringBuilder query = new StringBuilder();
        query.append(String.format("SELECT t FROM %s t ", getEntityName()));

        if (Objects.nonNull(filter)) {
            query.append(addWhereFromFilter(filter));
        }

        if (Objects.nonNull(filter.getPage())) {
            addSort(query, filter.getPage().getSort());
        }

        TypedQuery<T> tQuery = em.createQuery(query.toString(), getEntityClass());

        if (Objects.nonNull(filter.getPage())) {
            addPagination(tQuery, filter.getPage());
        }

        return tQuery.getResultList();
    }

    protected void addWhereClause(StringBuilder where, String clause, LogicOperatorsEnum operator) {
        if (where.isEmpty()) {
            where.append("WHERE ");
            where.append(clause);
            return;
        }

        where.append(operator.getOperator()).append(" ");
        where.append(clause).append(" ");
    }

    protected void addPagination(TypedQuery<T> tQuery, Pageable page) {
        tQuery.setFirstResult(page.getPageNumber() * page.getPageSize());
        tQuery.setMaxResults(page.getPageSize());
    }

    protected void addSort(StringBuilder query, Sort sort) {
        if (sort.isUnsorted()) {
            return;
        }

        String properties = String.join(",", sort.get().map(it -> it.getProperty() + " " + it.getDirection()).toList());
        query.append(String.format("ORDER BY %s", properties));
    }

    protected abstract String addWhereFromFilter(F filter);

    protected abstract Class<T> getEntityClass();

    protected abstract String getEntityName();

}
