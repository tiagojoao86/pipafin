package br.com.grupopipa.financeiro.business.base;

import br.com.grupopipa.financeiro.dto.DTO;
import br.com.grupopipa.financeiro.dto.FilterDTO;
import br.com.grupopipa.financeiro.entity.base.BaseEntity;
import br.com.grupopipa.financeiro.exception.EntityNotFoundException;
import br.com.grupopipa.financeiro.repository.base.BaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.UUID;
import java.util.function.IntFunction;


@Service
public abstract class BaseBusiness<T extends BaseEntity<D>, G extends DTO<T>, D extends DTO<T>, F extends FilterDTO, R extends JpaRepository<T,UUID>> {

    @Autowired
    private BaseDAO<D,T,F,R> repository;

    public abstract G convertEntityToGridObject(T item);

    public abstract IntFunction<G[]> createGridObjectArray();

    public abstract T createEntityObject();

    public abstract D createDtoObject();

    public abstract String getEntityClassName();

    public G[] list(F filter) {
        return repository.findWithFilter(filter).stream().map(this::convertEntityToGridObject)
                .toArray(createGridObjectArray());
    }

    public D save(D dto) {
        T entity = Objects.isNull(dto.getId()) ? createEntityObject() : findEntityById(dto.getId());
        entity.fillFromDTO(dto);

        entity = repository.save(entity);

        dto.fillFromEntity(entity);

        return dto;
    }

    public D findById(UUID id) {
        D dto = createDtoObject();
        T entity = repository.findById(id).orElseThrow(() -> new EntityNotFoundException(getEntityClassName(), id));
        dto.fillFromEntity(entity);
        return dto;
    }

    public UUID delete(UUID id) {
        repository.delete(findEntityById(id));
        return id;
    }

    private T findEntityById(UUID id) {
        return repository.findById(id).orElseThrow(() -> new EntityNotFoundException(getEntityClassName(), id));
    }
}
